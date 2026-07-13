#!/usr/bin/env bash

# strict mode
set -euo pipefail

# set variables
AGENT_ROOT="/home/agentes"
START_DIR="$(pwd -P)"

# security checks
[[ "$START_DIR" != "$AGENT_ROOT"* ]] && { echo "error: this script must be executed from within $AGENT_ROOT"; exit 1; }
command -v bwrap &>/dev/null || {   echo "error: bubblewrap is missing, install it via your package manager"; exit 1; }

# set tool and pass args
TOOL="${1:-opencode}"
shift || true
TOOL_ARGS=("$@")

echo "starting curated, network-isolated sandbox for $TOOL..."  # inform launch
ulimit -u 512                                                   # proc amount limit
ulimit -v 16777216                                              # memory limit

# BWRAP ARGUMENTS
#
# unshare-user, unshare-ipc, unshare-pid, unshare-cgroup
#   disable namespaces for process/mount isolation
# http_proxy / https_proxy / no_proxy
#   proxy-block internet while keeping localhost for Ollama
# die-with-parent make sandbox die with process end
# new-session create new session for process isolation
# tmpfs create temporal filesystem and mount /proc & /dev
# ro-bind binds main system directories as read only
# bind-try binds ollama socket for opencode comms
# setenv sets important environment variables in sb
# chdir changes working directory to the safe one
# TOOL finally runs the tool with the full setup

exec env -i PATH="/usr/bin:/bin:/usr/local/bin" \
  bwrap \
  --unshare-user \
  --unshare-ipc \
  --unshare-cgroup \
  --unshare-pid \
  --die-with-parent \
  --new-session \
  \
  --tmpfs / \
  --proc /proc \
  --dev /dev \
  \
  --tmpfs /tmp \
  --tmpfs /var/tmp \
  --tmpfs /run \
  \
  --ro-bind /usr /usr \
  --ro-bind /etc /etc \
  --ro-bind-try /bin /bin \
  --ro-bind-try /sbin /sbin \
  --ro-bind-try /lib /lib \
  --ro-bind-try /lib64 /lib64 \
  \
  --setenv OLLAMA_HOST "http://127.0.0.1:11434" \
  \
  --setenv http_proxy "http://127.0.0.1:9" \
  --setenv https_proxy "http://127.0.0.1:9" \
  --setenv no_proxy "127.0.0.1,localhost" \
  \
  --dir /home/agentes \
  --bind "$AGENT_ROOT/workspace" /home/agentes/workspace \
  --bind "$AGENT_ROOT/comms" /home/agentes/comms \
  --bind "$AGENT_ROOT/.config" /home/agentes/.config \
  --ro-bind "$AGENT_ROOT/havitat" /home/agentes/havitat \
  --tmpfs /home/agentes/.cache \
  \
  --setenv HOME /home/agentes \
  --setenv PATH /usr/bin:/bin:/usr/local/bin \
  --setenv NODE_ENV production \
  --setenv NODE_OPTIONS --no-warnings \
  --setenv XDG_CONFIG_HOME /home/agentes/.config \
  --setenv XDG_CACHE_HOME /home/agentes/.cache \
  \
  --chdir /home/agentes \
  "$TOOL" "${TOOL_ARGS[@]}"
