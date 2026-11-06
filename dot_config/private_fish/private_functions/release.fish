function release --description "Create a change request (HVSD) for a GitHub release"
    argparse n/dry-run -- $argv
    or return 1

    set -l jira_site https://hy-vee.atlassian.net
    set -l github_host github.hy-vee.cloud
    set -l concourse https://concourse-ci.hy-vee.cloud

    set -l peer_names "Amy Trinh" "Daniel An" "Michael Rogers" "Matthew Whitney"
    set -l peer_ids 712020:fed46b80-5056-4b8d-924f-896aca9d14a3 640f97571273131f2ae00007 712020:c412c30d-6be6-4683-9518-0f216fefb118 712020:e96653dd-dbd0-4043-94aa-8b47b30d7191
    set -l approver_id 60c76e7ea01e11006a44793a # Michael Poole

    set -l reason_names Maintenance Upgrade Repair "New functionality"
    set -l reason_ids 10013 10012 10011 10014

    set -l jira_token
    if not set -q _flag_dry_run
        set jira_token (pass show jira 2>/dev/null | head -n 1)
        if test -z "$jira_token"
            echo "Could not read the Jira API token from 'pass show jira'" >&2
            return 1
        end
    end
    set -l email (set -q JIRA_EMAIL; and echo $JIRA_EMAIL; or git config user.email)

    # Prompts
    read -P "Repo (org/name, e.g. digital/health): " repo
    if not string match -qr '^[^/\s]+/[^/\s]+$' -- $repo
        echo "Repo must look like org/name" >&2
        return 1
    end

    for i in (seq (count $peer_names))
        echo "  $i) $peer_names[$i]"
    end
    read -P "Peer approver [1-"(count $peer_names)"]: " peer_choice
    if not string match -qr '^[0-9]+$' -- $peer_choice; or test $peer_choice -lt 1 -o $peer_choice -gt (count $peer_names)
        echo "Pick a number from the list" >&2
        return 1
    end

    for i in (seq (count $reason_names))
        echo "  $i) $reason_names[$i]"
    end
    read -P "Change reason [1-"(count $reason_names)", default 1]: " reason_choice
    test -z "$reason_choice"; and set reason_choice 1
    if not string match -qr '^[0-9]+$' -- $reason_choice; or test $reason_choice -lt 1 -o $reason_choice -gt (count $reason_names)
        echo "Pick a number from the list" >&2
        return 1
    end

    read -P "Pre-change testing evidence: " testing_evidence
    read -P "Post-change validation plan: " validation_plan
    if test -z "$testing_evidence" -o -z "$validation_plan"
        echo "Testing evidence and validation plan are required" >&2
        return 1
    end

    # Find the release: a draft if there is one, else the latest published release
    set -lx GH_HOST $github_host
    set -l releases (gh api "repos/$repo/releases?per_page=20" | string collect)
    or begin
        echo "Could not list releases for $repo (are you on the VPN and logged in to gh?)" >&2
        return 1
    end

    set -l chosen (printf '%s' $releases | jq -c 'map(select(.draft))[0] // map(select(.draft | not))[0]' | string collect)
    if test "$chosen" = null
        echo "No releases found for $repo. Create the GitHub release first." >&2
        return 1
    end

    set -l release_name (printf '%s' $chosen | jq -r 'if (.name // "") != "" then .name else .tag_name end')
    set -l release_url (printf '%s' $chosen | jq -r '.html_url')
    set -l release_body (printf '%s' $chosen | jq -r '.body // ""' | string collect)
    set -l is_draft (printf '%s' $chosen | jq -r '.draft')

    # Backout target: the published release before this one
    set -l previous_index 0
    test "$is_draft" = false; and set previous_index 1
    set -l previous_tag (printf '%s' $releases | jq -r --argjson n $previous_index '[.[] | select(.draft | not)][$n].tag_name // empty')

    echo
    echo "Release: $release_name ($release_url)"
    test "$is_draft" = true; and echo "  (draft)"
    echo "Previous release: "(test -n "$previous_tag"; and echo $previous_tag; or echo "none found")
    read -P "Create a CR for this release? [Y/n] " confirm
    if string match -qir '^n' -- $confirm
        return 1
    end

    # Concourse team is the GitHub org, pipeline is the repo name
    set -l parts (string split / $repo)
    set -l job_url "$concourse/teams/$parts[1]/pipelines/$parts[2]/jobs/deploy-prod"

    set -l summary "Release $parts[2] $release_name"
    set -l description "$release_body

Release: $release_url"
    set -l implementation_plan "Run the deploy-prod job in Concourse: $job_url"
    set -l backout_plan "Re-run the previous deploy-prod build in Concourse$(test -n "$previous_tag"; and echo " (release $previous_tag)"): $job_url"
    set -l planned_start (date +%Y-%m-%dT%H:%M:%S.000%z)
    set -l planned_end (date -v+30M +%Y-%m-%dT%H:%M:%S.000%z)

    set -l payload (jq -n \
        --arg summary $summary \
        --arg description $description \
        --arg peer $peer_ids[$peer_choice] \
        --arg approver $approver_id \
        --arg reason $reason_ids[$reason_choice] \
        --arg testing $testing_evidence \
        --arg validation $validation_plan \
        --arg implementation $implementation_plan \
        --arg backout $backout_plan \
        --arg start $planned_start \
        --arg end $planned_end \
        '{
            serviceDeskId: "5",
            requestTypeId: "43",
            requestFieldValues: {
                summary: $summary,
                description: $description,
                priority: {id: "3"},
                customfield_10458: {id: "15449"},
                customfield_10139: {id: "18255"},
                customfield_10621: {id: "17681"},
                customfield_10007: {id: $reason},
                customfield_10622: $peer,
                customfield_10003: [{accountId: $approver}],
                customfield_10079: $implementation,
                customfield_10080: $backout,
                customfield_10624: $testing,
                customfield_10626: $validation,
                customfield_10082: $start,
                customfield_10083: $end
            }
        }' | string collect)

    if set -q _flag_dry_run
        printf '%s\n' $payload | jq .
        return 0
    end

    set -l response_file (mktemp)
    set -l http_status (curl -sS -o $response_file -w '%{http_code}' \
        -u "$email:$jira_token" \
        -H "Content-Type: application/json" \
        -X POST "$jira_site/rest/servicedeskapi/request" \
        -d $payload)

    if not string match -qr '^2' -- $http_status
        echo "Failed to create the change request (HTTP $http_status):" >&2
        jq . $response_file >&2; or cat $response_file >&2
        rm -f $response_file
        return 1
    end

    set -l issue_key (jq -r '.issueKey' $response_file)
    rm -f $response_file

    echo
    echo "Created $issue_key: $jira_site/browse/$issue_key"
    echo
    echo "Next:"
    echo "  1. Announce the release in the All HST | Releases channel on Teams (General Release) and add $issue_key"
    echo "  2. Wait for approval on the CR"
    echo "  3. Trigger deploy-prod: $job_url"
    echo "  4. Validate in prod, then resolve the CR, log time, and note any failures or rollbacks"
end
