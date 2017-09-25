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

More [command options can be found here](doc/options.md).

Now you are ready to check more example usages [here](doc/usage.md).

