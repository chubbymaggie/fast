### MacOSX using [Homebrew](https://brew.sh/) 
```
	$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	$ brew tap yijunyu/fast
	$ brew install fast
```
The 1st line is optional, it will install Homebrew if you hadn't got it.

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