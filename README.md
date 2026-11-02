# Backup Project

## About the Project

This is a Bash script that helps users create backups of their folders.

It creates compressed backup files and saves them in a backup folder. It also removes old backups automatically so that only the newest backups are kept.

## Features

- Creates backups of folders.
- Saves backups as `.tar.gz` files.
- Adds the date and time to each backup name.
- Allows users to choose where backups are saved.
- Allows users to choose how many backups to keep.
- Removes old backups automatically.
- Provides a help option.

## Requirements

- Linux terminal
- Bash
- `tar` command

## How to Use

First, make the script executable:

```bash
chmod +x backup.sh
```

Run the script using:

```bash
./backup.sh [OPTIONS] SOURCE
```

Replace `SOURCE` with the folder you want to back up.

## Available Options

| Option | Description |
|---|---|
| `-d DEST` | Choose where to save backups. |
| `-k KEEP` | Choose how many backups to keep. |
| `-h` | Display the help message. |

## Examples

Create a backup using the default settings:

```bash
./backup.sh ~/Documents
```

Save backups in a different location:

```bash
./backup.sh -d /media/usb/backups ~/Documents
```

Keep only the latest 3 backups:

```bash
./backup.sh -k 3 ~/Documents
```

Use both options together:

```bash
./backup.sh -d /media/usb/backups -k 3 ~/Documents
```

Display the help message:

```bash
./backup.sh -h
```

## Default Settings

- Backup location: `~/backups`
- Number of backups to keep: `5`

## Exit Codes

| Code | Meaning |
|---|---|
| `0` | Backup completed successfully. |
| `1` | Backup failed. |
| `2` | Wrong usage or invalid input. |

## Author

Created as a Bash programming project for learning and practising Linux terminal commands, shell scripting, and Git/GitHub.
# backup-project