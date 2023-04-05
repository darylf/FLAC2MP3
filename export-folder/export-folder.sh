#!/bin/bash

# Verify that both input directory and output filename are given as arguments
if [ $# -lt 2 ]; then
  echo "Usage: $0 [input directory] [output filename] [ignore file (optional)]"
  exit 1
fi

# Store input directory and output filename in variables
input_dir="$1"
output_file="$2"
ignore_file="$3"

# Check if input directory exists
if [ ! -d "$input_dir" ]; then
  echo "Input directory does not exist"
  exit 1
fi

# Create empty output file
> "$output_file"

echo "Project folder structure:" >> "$output_file"

# If an ignore file is provided, store its contents in an array
if [ -n "$ignore_file" ]; then
  # Check if ignore file exists
  if [ ! -f "$ignore_file" ]; then
    echo "Ignore file does not exist"
    exit 1
  fi

  # Read ignore file and store its contents in an array
  IFS=$'\n' read -d '' -r -a ignore_patterns < "$ignore_file"

  # Create the -I option for tree by joining the ignore patterns with '|'
  ignore_option=$(printf "|%s" "${ignore_patterns[@]}")
  ignore_option=${ignore_option:1}
  ignore_option="*$ignore_option*"

  # Run tree with the ignore option
  tree "$input_dir" -I "$ignore_option" >> "$output_file"
else
  # If no ignore file is provided, run tree without any options
  tree "$input_dir" >> "$output_file"
fi

# Loop through all files in input directory and subdirectories
find "$input_dir" -type f -print0 | while IFS= read -d '' -r file; do
  # Check if the file matches any of the ignore patterns
  skip_file=false
  for pattern in "${ignore_patterns[@]}"; do
    if [[ "$file" == *"$pattern"* ]]; then
      skip_file=true
      break
    fi
  done

  # If the file does not match any of the ignore patterns, print its name and contents to the output file
  if [ "$skip_file" = false ]; then
    # Replace the absolute file path with the relative file path
    file_path=$(realpath --relative-to="$input_dir" "$file")
    echo -e "\n\n\nFile: $file_path" >> "$output_file"
    echo -e "\n$(cat "$file")" >> "$output_file"
  fi
done
