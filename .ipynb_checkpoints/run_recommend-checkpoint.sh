#!/bin/bash
if [ -z "$MY_PYTHON" ]; then
    if command -v python3 &>/dev/null; then
        PYTHON=$(which python3)
    elif command -v python &>/dev/null; then
        PYTHON=$(which python)
    else
        echo "python3 또는 python이 없습니다."
        exit 1
    fi
else
    PYTHON="$MY_PYTHON"
fi

$PYTHON card_recommend.py "$@"
