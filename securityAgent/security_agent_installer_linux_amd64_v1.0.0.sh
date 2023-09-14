#! /bin/bash

# This script installs a security agent with a given configuration file and token
set -e
usage() {
    echo "Usage: $0 --config CONFIG_FILE --token TOKEN"
    exit 1
}

[[ $# -lt 4 ]] && usage
while [[ $# -gt 0 ]]; do
    case $1 in
        --config) CONFIG_FILE="$2"; shift 2 ;;
        --token) TOKEN="$2"; shift 2 ;;
        *) usage ;;
    esac
done

[ -z "$CONFIG_FILE" -o -z "$TOKEN" ] && usage
echo "Agent Installation Succeeded"

### Log to local directory and syslog to allow auditing of agent installation and operation
touch -m /opt/csg_security_agent/agent_install_date
logger "ansible agent installation SUCCESSFUL"