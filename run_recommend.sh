#!/bin/bash
if [ -z "$MY_PYTHON" ]; then
    PYTHON="/opt/anaconda3/bin/python3"
else
    PYTHON="$MY_PYTHON"
fi

echo "실행되는 파이썬: $PYTHON" >&2
$PYTHON --version >&2

$PYTHON card_recommend.py "$@"
