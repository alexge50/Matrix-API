cmake_minimum_required(VERSION 3.8)
project(matrix-compute LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 17)

find_package(CUDA QUIET REQUIRED)

include_directories(include)

set(source
        src/Matrix.cu
        )

cuda_add_library(matrix-compute ${source})

add_executable(test test/main.cu)
set_target_properties(test PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(test PRIVATE matrix-compute)