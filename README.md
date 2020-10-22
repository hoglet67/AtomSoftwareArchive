# AtomSoftwareArchive

Software relating to the Acorn Atom Software Archive of stardot.org.uk

## Dependencies

Dependencies for building the archive:
* ant
* java
* javac
* beebasm
* git

These executables must all be on the current PATH

## Installing Dependencies

```
sudo apt-get install openjdk-7-jdk ant git
git clone https://github.com/stardot/beebasm.git
cd beebasm/src
make clean
make code
sudo cp ../beebasm /usr/local/bin
```

## Building the Archive

You must build the archive on Linux; Windows is not supported.

To build the archive, you must be in the archive directory:
```
cd AtomSoftwareArchive/archive
```

Then just run the following script:
```
./scripts/make_archive.sh  V11.01 >& log
```
The V11.01 is the release number; this will get added to the splash screen.

This command redirects all output to a file called log (which ends up ~3MB)

Building takes a few minutes.

The result is a set of distribution files in the current directory:
```
	AtomSoftwareArchive_20201022_1807_V11.01.zip
	AtomSoftwareArchive_20201022_1807_V11.01_BEEBSCSI0.zip
	AtomSoftwareArchive_20201022_1807_V11.01_ECONET.zip
	AtomSoftwareArchive_20201022_1807_V11.01_JS.zip
	AtomSoftwareArchive_20201022_1807_V11.01_SDDOS2.zip
	AtomSoftwareArchive_20201022_1807_V11.01_SDDOS3.zip
```

## Checking for Errors

Review the log file for errors.

There are a number of expected errors in the log file:
```
grep Exception log 
java.lang.RuntimeException: Disk full is title: 1986WHO
java.lang.RuntimeException: Disk full is title: 11UNDER
java.lang.RuntimeException: Disk full is title: SW1X.TX
java.lang.RuntimeException: Disk full is title: SIDMENU
java.lang.RuntimeException: Disk full is title: WHATISL
java.lang.RuntimeException: Disk full is title: MOVIE0
java.lang.RuntimeException: Disk full is title: MOVIE2
java.lang.RuntimeException: Disk full is title: MOVIE2
java.lang.RuntimeException: Disk full is title: MOVIE4C
java.lang.RuntimeException: Disk full is title: 1986WHO
java.lang.RuntimeException: Disk full is title: 11UNDER
java.lang.RuntimeException: Disk full is title: SW1X.TX
java.lang.RuntimeException: Disk full is title: SIDMENU
java.lang.RuntimeException: Disk full is title: WHATISL
java.lang.RuntimeException: Disk full is title: MOVIE0
java.lang.RuntimeException: Disk full is title: MOVIE2
java.lang.RuntimeException: Disk full is title: MOVIE2
java.lang.RuntimeException: Disk full is title: MOVIE4C
```
These all relatate to files that cause certain 100KB disk images to overflow.

## Official Releases

Official binary releases can be found on github:

https://github.com/hoglet67/AtomSoftwareArchive/releases

(c) 2013-2020 David Banks
