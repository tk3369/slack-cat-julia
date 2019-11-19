#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: `basename $0` port"
    exit 1
fi

PORT=$1
re='^[1-9][0-9]+$'
if ! [[ $PORT =~ $re ]] ; then
    echo "Invalid port number: $PORT" >&2
    exit 1
fi

docker run -it -p "$PORT":"$PORT" -e PORT="$PORT" slack-cat-julia
