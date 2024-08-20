#!/bin/bash
version="1.0"

SCRIPT_DIR=$(dirname "$0")

OUTPUT_FILE="$SCRIPT_DIR/bin/build"
touch "$OUTPUT_FILE"

for script in $SCRIPT_DIR/src/commands/*.sh; do
    cat "$script" >> "$OUTPUT_FILE"
done

cat src/main.sh > "$OUTPUT_FILE"

chmod +x "$OUTPUT_FILE"

cp "$OUTPUT_FILE" /bin/capsule
