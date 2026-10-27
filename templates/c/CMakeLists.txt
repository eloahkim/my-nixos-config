cmake_minimum_required(VERSION 3.20)
project(@PROJECT_SLUG@ C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(main main.c)

enable_testing()
add_test(NAME run COMMAND main)
