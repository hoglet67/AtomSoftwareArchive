# AtomSoftwareArchive

Software relating to the Acorn Atom Software Archive of stardot.org.uk

## Dependencies

Dependencies for building the archive:
* `ant`
* `java`
* `javac`
* `beebasm`
* `git`
* `wget`
* `acme`
* `LZSA`

On MacOS (or Linux), you will also need [homebrew](https://brew.sh)

These executables must all be on the current `PATH`.

## Installing Dependencies

### Linux
```
sudo apt-get install openjdk-7-jdk ant git
git clone https://github.com/stardot/beebasm.git
cd beebasm/src
make clean
make code
sudo cp ../beebasm /usr/local/bin
```

### MacOS

Assuming you followed the instructions already for *Homebrew*

```
brew install ant acme lzsa openjdk@25
```

> Versions tested
> * ant 1.10.15_1 
> * acme 0.97
> * lzsa 1.4.1
> * openjdk 25

After installation of JAVA, update your `PATH` environment variables to point to the JDK, and `beebasm`

 $ `echo 'export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"' >> $HOME/.zshrc`
 $ `source $HOME/.zshrc`

Install beebasm locally.  You can change directory to a suitable build or binaries directory first.

```
git clone https://github.com/stardot/beebasm.git beebasm_bin
cd beebasm_bin/src
make clean
make code
cd ..
echo 'export PATH="'$(pwd)':$PATH"' >> $HOME/.zshrc
source $HOME/.zshrc
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

## Known Issues with Econet

- Program Power Chess - doesn't load over Econet.

- The RS/GALA, RS/CHUCKIE, ECCE directories all contain a file called
  MENU, which means subsequent Shift-BREAK don't work as *MENU loads
  that file, rather than the one in the library directory. Ideally
  these should be renamed.

(c) 2013-2020 David Banks
