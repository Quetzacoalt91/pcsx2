# Tell cmake we are cross compiling and targeting linux
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_SYSROOT /home/devel/rasp-pi-rootfs)
set(CMAKE_STAGING_PREFIX /home/devel/stage)

set(tools /home/devel/gcc-4.7-linaro-rpi-gnueabihf)
set(CMAKE_C_COMPILER ${tools}/bin/arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/arm-linux-gnueabihf-g++)

# cmake 2.8.5 correctly sets CMAKE_LIBRARY_ARCHITECTURE for Debian multiarch.
# Be really strict about what gets used.
if(EXISTS /usr/lib/i386-linux-gnu)
    set(CMAKE_SYSTEM_IGNORE_PATH
        /lib             /lib64             /lib32
        /usr/lib         /usr/lib64         /usr/lib32
        /usr/local/lib   /usr/local/lib64   /usr/local/lib32)
    list(APPEND CMAKE_LIBRARY_PATH /usr/local/lib/i386-linux-gnu)
    list(APPEND CMAKE_LIBRARY_PATH /usr/lib/i386-linux-gnu)
    list(APPEND CMAKE_LIBRARY_PATH /lib/i386-linux-gnu)
elseif(EXISTS /usr/lib32)
    set(CMAKE_SYSTEM_IGNORE_PATH
        /lib             /lib64
        /usr/lib         /usr/lib64
        /usr/local/lib   /usr/local/lib64)
    set(CMAKE_LIBRARY_ARCHITECTURE "../lib32")
    list(APPEND CMAKE_LIBRARY_PATH /usr/local/lib32)
    list(APPEND CMAKE_LIBRARY_PATH /usr/lib32)
    list(APPEND CMAKE_LIBRARY_PATH /lib32)
else()
    set(CMAKE_SYSTEM_IGNORE_PATH
        /lib64
        /usr/lib64
        /usr/local/lib64)
    set(CMAKE_LIBRARY_ARCHITECTURE ".")
    list(APPEND CMAKE_LIBRARY_PATH /usr/local/lib)
    list(APPEND CMAKE_LIBRARY_PATH /usr/lib)
    list(APPEND CMAKE_LIBRARY_PATH /lib)
endif()
list(REMOVE_DUPLICATES CMAKE_LIBRARY_PATH)

# If given a CMAKE_FIND_ROOT_PATH then
# FIND_PROGRAM ignores CMAKE_FIND_ROOT_PATH (probably can't run)
# FIND_{LIBRARY,INCLUDE,PACKAGE} only uses the files in CMAKE_FIND_ROOT_PATH.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
