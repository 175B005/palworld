#!/bin/sh
UE_TRUE_SCRIPT_NAME=$(echo \"$0\" | xargs readlink -f)
UE_PROJECT_ROOT=$(dirname "$UE_TRUE_SCRIPT_NAME")
SOURCE="$UE_PROJECT_ROOT/linux64/steamclient.so"
DESTINATION="$UE_PROJECT_ROOT/Pal/Binaries/Linux/steamclient.so"
if [ ! -d "$(dirname "$DESTINATION")" ]; then
    echo "The destination directory does not exist: $(dirname "$DESTINATION")"
    exit 1
fi
if [ -f "$DESTINATION" ]; then
    echo "The file already exists: $DESTINATION"
else
    if cp "$SOURCE" "$DESTINATION"; then
        echo "The file has been successfully copied: $SOURCE -> $DESTINATION"
    else
        echo "Failed to copy the file: $SOURCE -> $DESTINATION"
        exit 1
    fi
fi
chmod +x "$UE_PROJECT_ROOT/Pal/Binaries/Linux/PalServer-Linux-Shipping"
"$UE_PROJECT_ROOT/Pal/Binaries/Linux/PalServer-Linux-Shipping" Pal "$@" 
