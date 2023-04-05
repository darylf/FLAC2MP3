# Project folder structure and file contents exporter

This script exports the folder structure and file contents of a given directory to a text file, optionally excluding some files and directories.

## Usage

The script requires at least two arguments: the input directory and the output filename.

``` bash
./export-folder.sh [input directory] [output filename] [ignore file (optional)]
```

* [input directory]: path to the directory whose contents should be exported.
* [output filename]: path to the file where the output should be saved.
* [ignore file (optional)]: path to a file containing a list of patterns to exclude from the output. This file should have one pattern per line.

If an ignore file is provided, the script will exclude from the output all files and directories whose path contains any of the patterns in the ignore file.

## Output

The output file will contain the following sections:

1. The project folder structure, as produced by the tree command.
2. The contents of each file in the input directory and its subdirectories, except for those that match any of the patterns in the ignore file (if provided).

The file names and contents will be relative to the input directory. Note that the file contents will be concatenated to the output file, so the resulting file can be very large depending on the size of the input directory and its files.

## Example

Suppose we have a directory `/home/user/project` with the following structure:

``` text
.
├── src
│   ├── main
│   │   ├── java
│   │   └── resources
│   └── test
│       ├── java
│       └── resources
└── README.md
```

We can run the script to export the contents of the src directory, excluding the test directory, to a file /home/user/project-output.txt:

``` bash
./export-folder.sh /home/user/project/src /home/user/project-output.txt /home/user/project-ignore.txt
```

Assuming that /home/user/project-ignore.txt contains the following pattern:

``` text
test
```

The output file will contain:

``` text
Project folder structure:
/home/user/project/src
├── main
│   ├── java
│   └── resources
└── README.md


File: main/java/MyClass.java

public class MyClass {
  // ...
}

File: main/resources/config.properties

server.port=8080
db.host=localhost
db.port=5432
db.name=mydb
db.user=admin
db.password=secretpassword
```

## Notes

* The script was tested on Ubuntu Linux 20.04, but it should work on other Linux distributions and macOS as well.
* The script assumes that the tree and find commands are available in the system.
* The script may take a long time to run depending on the size of the input directory and the number of files to export.
* The script does not handle file names or directory paths with spaces or special characters.

