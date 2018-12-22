cmake_minimum_required(VERSION 3.8)
project(matrix-compute LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 17)

find_package(CUDA QUIET REQUIRED)

set(source
        main.cu
        )

cuda_add_executable(matrix-compute ${source})
set_target_properties(matrix-compute PROPERTIES CUDA_SEPARABLE_COMPILATION ON)