cmake_minimum_required(VERSION 3.9)

project(matrix CXX CUDA)

set(CMAKE_CXX_STANDARD 17)

set(source
        matrix.cu
        )

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(Boost COMPONENTS python3 REQUIRED)
find_package(PythonLibs REQUIRED)

include_directories("${matrix-compute_SOURCE_DIR}/include" ${Boost_INCLUDE_DIR} ${PYTHON_INCLUDE_DIRS})


link_directories(${matrix-compute_BIN_DIR})

python_add_module(matrix ${source})
target_link_libraries(matrix matrix-compute ${Boost_LIBRARIES} ${PYTHON_LIBRARIES})
set_target_properties(matrix PROPERTIES LIBRARY_OUTPUT_DIRECTORY "${matrix_SOURCE_DIR}")