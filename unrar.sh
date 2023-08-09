#!/bin/bash

# Function to recursively unrar files in a directory
unrar_recursive() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            unrar_recursive "$file"
        elif [[ "$file" == *.rar ]]; then
            echo "Unraring $file"
            unrar x -o- "$file" "$1"
        fi
    done
}

# Watch the volumes for new files
watch_volumes() {
    while true; do
        inotifywait -r -e create,move,close_write --format '%w%f' "$@"
        echo "New file detected. Running unrar_recursive..."
        unrar_recursive "$@"
    done
}

# Start watching the volumes for changes
watch_volumes "$@"