:: Build out-of-tree.
mkdir build
cd build

:: Config
cmake -G Ninja ^
    %CMAKE_ARGS% ^
    -DANTS_SUPERBUILD:BOOL=OFF ^
    -DBUILD_SHARED_LIBS:BOOL=ON ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    -DCMAKE_INSTALL_LIBDIR:STRING=%LIBRARY_LIB% ^
    -DCMAKE_INSTALL_PREFIX:STRING=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH:STRING=%LIBRARY_PREFIX% ^
    -DRUN_SHORT_TESTS:BOOL=ON ^
    -DRUN_LONG_TESTS:BOOL=OFF ^
    -DUSE_SYSTEM_ITK:BOOL=ON ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Build
cmake --build . --config Release --parallel %CPU_COUNT%
if errorlevel 1 exit 1

:: Test
ctest -C Release --output-on-failure
if errorlevel 1 exit 1

:: Install
cmake --build . --config Release --target install
if errorlevel 1 exit 1
