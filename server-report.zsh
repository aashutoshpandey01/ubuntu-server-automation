#!/usr/bin/env zsh

echo "========================================="
echo "        SERVER HEALTH REPORT"
echo "========================================="
echo "Date: $(date)"
echo "Hostname: $(hostname)"
echo

# SSH Status
if systemctl is-active --quiet ssh; then
    echo "✅ SSH      : RUNNING"
else
    echo "❌ SSH      : STOPPED"
fi

# Nginx Status
if systemctl is-active --quiet nginx; then
    echo "✅ Nginx    : RUNNING"
else
    echo "❌ Nginx    : STOPPED"
fi

# Disk Usage
USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')
echo "💾 Root Disk: ${USAGE}% Used"

# Memory
echo
echo "Memory:"
free -h

# Uptime
echo
echo "Uptime:"
uptime

echo
echo "========================================="
