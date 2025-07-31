#!/bin/bash

BIN_DIR="./bin"
          
# Find all executable files in the specified folder
find "$BIN_DIR" -type f -name '*_test' -executable -print0 | while IFS= read -r -d $'\0' binary_path; do
	echo "Running: $binary_path"
	"$binary_path" # Execute the binary
	if [ $? -ne 0 ]; then
		echo "Error running $binary_path"
		exit 1 # Exit if a binary fails
	fi
done
