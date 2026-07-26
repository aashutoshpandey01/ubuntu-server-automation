#!/usr/bin/env zsh

if systemctl is-active --quiet nginx; then
    echo "✅ Nginx Service: RUNNING"
else
    echo "❌ Nginx Service: STOPPED"
fi
