project(RORPO2D)
cmake_minimum_required(VERSION 2.8)
set(CMAKE_CXX_FLAGS "-std=c++98")

#if(UNIX)
#    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -std=gnu++1y") # C++ 11 activation flag
#        SET(LIB_TYPE SHARED)
#else()
#        SET(LIB_TYPE STATIC)
#endif()

# Add files
#file( GLOB_RECURSE HEADER_FILES *.h *.hpp)
#file( GLOB_RECURSE SOURCE_FILES *.c *.cpp )
file(GLOB SOURCE_FILES "${CMAKE_SOURCE_DIR}/*.cpp")
file(GLOB HEADER_FILES "${CMAKE_SOURCE_DIR}/*.hpp")

# Find libpng library
find_package(PNG REQUIRED)
include_directories(${PNG_INCLUDE_DIR})

# Create executable and link library
add_executable(${PROJECT_NAME} ${SOURCE_FILES} ${HEADER_FILES})
target_link_libraries(${PROJECT_NAME} ${PNG_LIBRARY})


