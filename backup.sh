#!/bin/bash

#Here i set where my backups will be saved and how many i want to keep.
dest="$HOME/backups"
keep=5
verbose=false

#This function shows the user how to use my backup script.
usage() {
cat <<EOF
Usage: $(basename "$0") [-d DEST] [-k KEEP] [-v] SOURCE
Options:
-d DEST where to store backups (default: $dest)
-k KEEP how many backups to keep (default: $keep)
-v verbose output
-h show this help
EOF
}

#This will show and error when something goes wrong.
   die() {
    echo "Error: $*" >&2
    exit 1

}

#This function shows extra information when verbose mode is on.
log() {
if [[ "$verbose" == true ]]; then
echo "[$(date +%H:%M:%S)] $*"
fi
}

#Here I create a backup of my folder and add the date and time to its name.
create_backup() {
    local source="$1"
    local folder=$(basename "$(realpath "$source")")
    local time=$(date +%Y%m%d-%H%M%S)

    mkdir -p "$dest"

    tar -czf "$dest/$folder-$time.tar.gz" -C "$(dirname "$source")" "$folder"

    echo "Backup created: $dest/$folder-$time.tar.gz"
}

#This function will delete the oldest backups if there are more than the number specified in the keep variable.
    rotate_backups() {
    local folder="$1"

    cd "$dest" || return 1

    ls -1t "$folder"-*.tar.gz 2>/dev/null | tail -n +"$((keep + 1))" | while read -r file
    do
        rm -- "$file"
    done
}

#This is the main function that will run the script and call the other functions.
main() {

    OPTIND=1

#checking the options the user enters when running the script.
    while getopts ":d:k:h" opt; do
        case "$opt" in
            d) dest="$OPTARG" ;;
            k) keep="$OPTARG" ;;
            h) usage; exit 0 ;;
            \?) echo "Error: Unknown option" >&2; exit 2 ;;
            :) echo "Error: option -$OPTARG requires a value" >&2; exit 2 ;;
        esac

    done

    shift $((OPTIND - 1))

    source_dir="$1"

    # Check if source_dir is provided
    if [[ -z "$source_dir" ]]; then
         die "please provide a source directory"
    fi

    # Check if source is a directory
if [[ ! -d "$source_dir" ]]; then
    die "Source folder does not exist or is not a directory"
fi

# Check if keep is a positive number
if [[ ! "$keep" =~ ^[1-9][0-9]*$ ]]; then
    die "keep must be a positive whole number"
fi

create_backup "$source_dir"
rotate_backups "$(basename "$source_dir")"

} 



main "$@"