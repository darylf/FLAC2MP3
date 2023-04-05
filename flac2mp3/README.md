# FLAC to MP3 Converter

This script converts FLAC audio files to MP3 format and adds ID3 tags to the output files. The output files are saved in the mp3 directory located in the same directory as the input files.

## Usage

The script should be run from the directory containing the FLAC files that need to be converted.

```bash
./flac-to-mp3.sh
```

The script does not accept any arguments.

## Output

The output files will be saved in the mp3 directory, with the same filename as the input file, but with the .mp3 extension.
Notes

* The script assumes that flac, lame, and id3cp are installed on the system and available in the PATH.
* The script does not handle file names or directory paths with spaces or special characters.
* The script will create the mp3 directory if it does not exist in the same directory as the input files.
* The script will output a message for each file being converted, showing the filename being processed.
* The script does not delete the original FLAC files after conversion.
