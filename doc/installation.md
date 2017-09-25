### Installation
It is recommended to use [docker](https://www.docker.com)

First [install docker](https://docs.docker.com/engine/installation/), then simply run
```
	$ docker run -w /examples -v$(pwd)/test:/examples -it yijun/fast
```
If this is the first time running the above command, you will see some downloading processes.  
After the installation is done, you will be prompted to enter `fast` commands. 

```
/examples #
```

To check everything is ready, just enter the following command:

```
/examples # fast -v
```

You will see some version information like below, indicating which version of `fast` 
has been installed, when, and by which version of C++ compiler, etc.:
```
fast v3.6.2 commit id: edfdd292bac88862accdf0501d09635cfc9ff67c with local changes id: 
built with 6.4.0 on Sep 25 2017 at 06:32:42
```

More [command options can be found here](options.md).

Now you are ready to check more example usages [here](usage.md).

### Specific hint on running `fast` with Docker on Windows

Make sure you turn on the "Hyper-V" option on BIOS menu, to enable virtualisation. Then you need to enable "Shared Drive" on the Docker menu so that the local folder can be mounted to the container. By default, the docker is bound to Linux containers, so you don't need to anything else. Note that the Linux container does not work if you switched to Windows container on the menu, in such a case you should let Docker switch back to using Linux containers.

The Windows path name should contain a drive letter too. 
E.g., suppose you have got the Git repository checked out under your `Documents` folder,
you can run the following command to start using `fast`. 
```
	$ docker run -w /examples -v c:/Users/<user>/Documents/f-ast/fast/test:/examples -it yijun/fast
```

## For development

### MacOSX using [Homebrew](https://brew.sh/) 
```
	$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	$ brew tap yijunyu/fast
	$ brew install srcml antlr antlr4-cpp-runtime libxml2 lcov protobuf flatbuffers
	$ brew install --ignore-dependencies fast
```
The 1st line is optional, it will install Homebrew if you hadn't got it. The 2nd line update the brew repository to include our tools.
The 3rd line installs all the dependencies that is the prerequisite to use fast. Note that we need to do this separately from the 4th
line, because there is a dependency conflict between antlr@2 and the default antlr4 required by some commands in fast.

#### Caveat, reported and fixed by Bram Adams
If you are installing the tool on Yosemite, are the system complains about 
```
dyld: Library not loaded: @@HOMEBREW_PREFIX@@/opt/LibArchive/lib/libarchive.13.dylib
  Referenced from: /usr/local/bin/srcml
  Reason: image not found
```
You can fix this problem by the following workaround using `install_name_tool`:
```
sudo install_name_tool -change @@HOMEBREW_PREFIX@@/opt/LibArchive/lib/libarchive.13.dylib /usr/local/Cellar/libarchive/3.3.1/lib/libarchive.13.dylib /usr/local/bin/srcml
```

#### Caveat, reported and fixed by Chunmiao Li
If you have previously installed srcml using brew, and got an error "srcml not found", you may need to run the following to fix it:
```
	$ brew unlink srcml && brew link --overwrite srcml
```
### Ubuntu Linux using Debian packages:
```
	$ sudo apt-get install apt-transport-https
	$ sudo su -
	$ echo deb http://yijunyu.github.io/ubuntu ./ >> /etc/apt/sources.list
	$ apt-get update
	$ apt-get install fast
```
Specifically, the 1st line is to support HTTPS transport protocol for the repository on github.io; 
the 2nd line is to update the list of repositories on your machine.

