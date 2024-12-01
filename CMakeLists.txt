cmake_minimum_required(VERSION 3.10)
project(YourProjectName)

find_package(OpenGL REQUIRED)
find_package(GLEW REQUIRED)
find_package(glfw3 REQUIRED)

add_executable(window main.cpp)
target_link_libraries(window OpenGL::GL GLEW::GLEW glfw)

