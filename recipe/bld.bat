mkdir build
if errorlevel 1 exit 1
cd build
if errorlevel 1 exit 1

cmake ^
    %CMAKE_ARGS% ^
    -DCMAKE_INSTALL_LIBDIR:STRING=%LIBRARY_LIB% ^
    -DCMAKE_INSTALL_PREFIX:STRING=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH:STRING=%LIBRARY_PREFIX% ^
    -DBUILD_SHARED_LIBS:BOOL=ON ^
    -DANTS_SUPERBUILD:BOOL=OFF ^
    -DUSE_SYSTEM_ITK:BOOL=ON ^
    -DCMAKE_BUILD_TYPE:STRING=Release ^
    %SRC_DIR%
if errorlevel 1 exit 1

cmake --build . --config Release --parallel %CPU_COUNT% --target install
if errorlevel 1 exit 1
