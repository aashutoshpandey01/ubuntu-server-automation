#!/usr/bin/env zsh

if systemctl is-active --quiet ssh; then
    echo "✅ SSH Service: RUNNING"
else
    echo "❌ SSH Service: STOPPED"
fi
