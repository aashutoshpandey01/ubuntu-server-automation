#!/usr/bin/env zsh

echo "========== SERVER HEALTH =========="
echo

echo "Hostname:"
hostname
echo

echo "Current Date & Time:"
date
echo

echo "Server Uptime:"
uptime
echo

echo "CPU Load:"
uptime
echo

echo "SSH Status:"
systemctl is-active ssh
echo

echo "Nginx Status:"
systemctl is-active nginx
echo

echo "Root Disk Usage:"
df -h /
echo

echo "Memory Usage:"
free -h
echo

echo "=================================="
