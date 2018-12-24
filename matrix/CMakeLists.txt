cmake_minimum_required(VERSION 3.8)
project(matrix-compute CUDA CXX)

set(CMAKE_CXX_STANDARD 17)

include_directories(include)

set(source
        include/Matrix.h
        src/Matrix.cu
        )

add_library(matrix-compute STATIC ${source})
set_target_properties(matrix-compute PROPERTIES CUDA_SEPARABLE_COMPILATION ON)


add_executable(test test/main.cu)
set_target_properties(test PROPERTIES CUDA_SEPARABLE_COMPILATION ON)
target_link_libraries(test matrix-compute)