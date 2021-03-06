![logo](https://code.google.com/p/omegalib/logo?cct=1370642046) omegalib
========
[![Build Status](https://travis-ci.org/uic-evl/omegalib.svg?branch=master)](https://travis-ci.org/uic-evl/omegalib)

<img src="https://github.com/uic-evl/omegalib/wiki/intro/banner.jpg"/>

A creative framework for virtual reality and cluster-driven display systems.

- Intro page: http://uic-evl.github.io/omegalib/
- Wiki: https://github.com/uic-evl/omegalib/wiki
- Omegalib modules hub: https://github.com/omega-hub

## If you are in a rush: ##
**Download a Windows precompiled version**: https://github.com/febret/omegalib-windows/archive/master.zip

**Use the quick build scripts** You will need the following installed:
- Git
- CMake (http://www.cmake.org/)
- Python (the pre-installed 2.7 version on OSX and most linux distros works fine, on Windows omegalib comes with python bundled so you don't need this)
- C++ Build tools for your platform (g++, clang/XCode, Visual Studio 2012/2013 depending on the OS). On windows, the free Visual Studio editions work fine. 
- (**linux**) The following packages
  - OpenGL development libraries (`freeglut3`, `freeglut3-dev`)
  - Python development libraries (`python-dev`)
  - Flex and bison (`flex` and `bison`)
  - To install all of them on Ubunto do `sudo apt-get install freeglut3 freeglut3-dev python-dev flex bison`)

(**Linux/OSX**)
```
> mkdir omegalib
> cd omegalib
> (on LINUX) wget http://omegalib.s3.amazonaws.com/maintenance-utils/omega
> (on OSX)   curl http://omegalib.s3.amazonaws.com/maintenance-utils/omega -o omega
> chmod +x omega
> ./omega get master common-modules
```

(**Windows**): download http://omegalib.s3.amazonaws.com/maintenance-utils/omega.bat in a new directory and from the command line run:
```
> omega get master common-modules
```

## Additional Information: ##
- More info on building: https://github.com/uic-evl/omegalib/wiki/Building
- Troubleshooting and FAQ: https://github.com/uic-evl/omegalib/wiki/HowTos
- Support Forum: https://groups.google.com/forum/#!forum/omegalib
 
For omegalib versions before 5.0 go to https://github.com/uic-evl/omegalib-history

## Credit ##
If you need to reference Omegalib in your research work you can use the following citation:

> Febretti, A.; Nishimoto, A.; Mateevitsi, V.; Renambot, L.; Johnson, A.; Leigh, J., "Omegalib: A multi-view application framework for hybrid reality display environments," Virtual Reality (VR), 2014 iEEE , vol., no., pp.9,14, March 29 2014-April 2 2014
doi: 10.1109/VR.2014.6802043

<a href="https://plus.google.com/105527429589387055081" rel="publisher">Google+</a>
