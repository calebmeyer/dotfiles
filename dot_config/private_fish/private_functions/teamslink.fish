function teamslink --description 'Turn a markdown link on the clipboard into a rich-text hyperlink Teams will accept'
    set -l markdown (pbpaste)

    if test -z "$markdown"
        echo "teamslink: clipboard is empty" >&2
        return 1
    end

    set -l html (printf '%s' "$markdown" | perl -pe '
        s/&/&amp;/g; s/</&lt;/g; s/>/&gt;/g;
        s{\[([^\]]+)\]\(([^)]+)\)}{<a href="$2">$1</a>}g;
    ')

    if not string match -q '*<a href=*' -- $html
        echo "teamslink: no markdown link found on the clipboard" >&2
        return 1
    end

    printf '%s' "$html" | textutil -stdin -format html -convert rtf -stdout | pbcopy -Prefer rtf
end
