#!/usr/bin/env bash

# Abort on error.
set -ex

# Build out-of-tree.
mkdir build
cd build

# Config
cmake -G Ninja \
    ${CMAKE_ARGS} \
    -DANTS_SUPERBUILD:BOOL=OFF \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_BUILD_TYPE:STRING=Release \
    -DCMAKE_INSTALL_LIBDIR:STRING=lib \
    -DCMAKE_INSTALL_PREFIX:STRING=${PREFIX} \
    -DCMAKE_PREFIX_PATH:STRING=${PREFIX} \
    -DRUN_SHORT_TESTS:BOOL=ON \
    -DRUN_LONG_TESTS:BOOL=OFF \
    -DUSE_SYSTEM_ITK:BOOL=ON \
    ${SRC_DIR}

# Build
cmake --build . --parallel ${CPU_COUNT}

# Install
cmake --build . --parallel ${CPU_COUNT} --target install

# Test
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
ctest --parallel ${CPU_COUNT} --extra-verbose --output-on-failure
fi
