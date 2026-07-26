#!/usr/bin/env zsh

THRESHOLD=80

USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo "⚠️ WARNING: Root disk usage is ${USAGE}%"
else
    echo "✅ Root disk usage is ${USAGE}%"
fi
