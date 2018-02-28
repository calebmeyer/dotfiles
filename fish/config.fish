set -x DOCKER_HOST 'tcp://0.0.0.0:2375'

# Load pyenv
set -x PATH "/home/caleb/.pyenv/bin" $PATH
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (pyenv virtualenv-init -|psub)

# Load rbenv
set -x PATH "/home/caleb/.rbenv/bin" $PATH
status --is-interactive; and . (rbenv init -|psub)
