#!/bin/sh

mkdir build
cd build

CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

cmake ${CMAKE_ARGS} -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_SYSTEM_RUNTIME_LIBS_SKIP=True \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_TESTING=ON \
      -DGZ_UTILS_VENDOR_CLI11=OFF \
      ..

cmake --build . --config Release --parallel ${CPU_COUNT}
cmake --build . --config Release --parallel ${CPU_COUNT} --target install
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
  ctest --output-on-failure -C Release
fi
