#!/usr/bin/env zsh

# ======================================
# BACKUP SCRIPT
# ======================================

DATE=$(date +%Y-%m-%d_%H-%M-%S)

# ======================================
# 1. WEBSITE BACKUP
# ======================================

SOURCE="/srv/projects/website"
BACKUP_DIR="$HOME/backups"

mkdir -p "$BACKUP_DIR"

BACKUP_FILE="$BACKUP_DIR/website-${DATE}.tar.gz"

tar -czf "$BACKUP_FILE" "$SOURCE"

if [[ $? -eq 0 ]]; then
    echo "Website backup completed successfully!"
    echo "Backup File:"
    echo "$BACKUP_FILE"
else
    echo "ERROR: Website backup failed!"
fi


# ======================================
# 2. SERVER CONFIGURATION BACKUP
# ======================================

ARCHIVE_DIR="/home/cloudadmin/backups/archives"
REMOTE_DIR="/home/cloudadmin/backups/remote"

ARCHIVE_NAME="server-backup-${DATE}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"

mkdir -p "$ARCHIVE_DIR"
mkdir -p "$REMOTE_DIR"

echo
echo "Creating server configuration backup..."

sudo tar -czf "$ARCHIVE_PATH" \
    /etc/ssh \
    /etc/nginx \
    /etc/fstab \
    /home/cloudadmin/important-data

if [[ $? -ne 0 ]]; then
    echo "ERROR: Server configuration backup failed!"
    exit 1
fi

echo "Server archive created successfully:"
echo "$ARCHIVE_PATH"


# ======================================
# 3. RSYNC BACKUP
# ======================================

echo
echo "Copying server backup using rsync..."

rsync -avh "$ARCHIVE_PATH" "$REMOTE_DIR/"

if [[ $? -ne 0 ]]; then
    echo "ERROR: rsync backup failed!"
    exit 1
fi

echo "rsync completed successfully!"


# ======================================
# 4. INTEGRITY VERIFICATION
# ======================================

echo
echo "SHA256 CHECKSUMS:"

sha256sum "$ARCHIVE_PATH"
sha256sum "$REMOTE_DIR/$ARCHIVE_NAME"


# ======================================
# COMPLETE
# ======================================

echo
echo "======================================="
echo "ALL BACKUPS COMPLETED SUCCESSFULLY!"
echo "======================================="
