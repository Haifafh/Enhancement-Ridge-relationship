# Install script for directory: /Users/haifa/curvilinear-methods/lib/qhull-2015.2

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libqhullcpp.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE STATIC_LIBRARY FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhullcpp.a")
  if(EXISTS "$ENV{DESTDIR}/usr/local/lib/libqhullcpp.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/lib/libqhullcpp.a")
    execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib" "$ENV{DESTDIR}/usr/local/lib/libqhullcpp.a")
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libqhullstatic.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE STATIC_LIBRARY FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhullstatic.a")
  if(EXISTS "$ENV{DESTDIR}/usr/local/lib/libqhullstatic.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/lib/libqhullstatic.a")
    execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib" "$ENV{DESTDIR}/usr/local/lib/libqhullstatic.a")
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libqhullstatic_r.a")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE STATIC_LIBRARY FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhullstatic_r.a")
  if(EXISTS "$ENV{DESTDIR}/usr/local/lib/libqhullstatic_r.a" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/lib/libqhullstatic_r.a")
    execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib" "$ENV{DESTDIR}/usr/local/lib/libqhullstatic_r.a")
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libqhull_r.7.2.0.dylib;/usr/local/lib/libqhull_r.7.dylib;/usr/local/lib/libqhull_r.dylib")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE SHARED_LIBRARY FILES
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhull_r.7.2.0.dylib"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhull_r.7.dylib"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhull_r.dylib"
    )
  foreach(file
      "$ENV{DESTDIR}/usr/local/lib/libqhull_r.7.2.0.dylib"
      "$ENV{DESTDIR}/usr/local/lib/libqhull_r.7.dylib"
      "$ENV{DESTDIR}/usr/local/lib/libqhull_r.dylib"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      execute_process(COMMAND "/opt/local/bin/install_name_tool"
        -id "/usr/local/lib/libqhull_r.7.dylib"
        "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/bin/qhull")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/bin" TYPE EXECUTABLE FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/qhull")
  if(EXISTS "$ENV{DESTDIR}/usr/local/bin/qhull" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/bin/qhull")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "$ENV{DESTDIR}/usr/local/bin/qhull")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/bin/rbox")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/bin" TYPE EXECUTABLE FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/rbox")
  if(EXISTS "$ENV{DESTDIR}/usr/local/bin/rbox" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/bin/rbox")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "$ENV{DESTDIR}/usr/local/bin/rbox")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/bin/qconvex")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/bin" TYPE EXECUTABLE FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/qconvex")
  if(EXISTS "$ENV{DESTDIR}/usr/local/bin/qconvex" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/bin/qconvex")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "$ENV{DESTDIR}/usr/local/bin/qconvex")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/bin/qdelaunay")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/bin" TYPE EXECUTABLE FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/qdelaunay")
  if(EXISTS "$ENV{DESTDIR}/usr/local/bin/qdelaunay" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/bin/qdelaunay")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "$ENV{DESTDIR}/usr/local/bin/qdelaunay")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/bin/qvoronoi")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/bin" TYPE EXECUTABLE FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/qvoronoi")
  if(EXISTS "$ENV{DESTDIR}/usr/local/bin/qvoronoi" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/bin/qvoronoi")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "$ENV{DESTDIR}/usr/local/bin/qvoronoi")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/bin/qhalf")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/bin" TYPE EXECUTABLE FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/qhalf")
  if(EXISTS "$ENV{DESTDIR}/usr/local/bin/qhalf" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/bin/qhalf")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "$ENV{DESTDIR}/usr/local/bin/qhalf")
    endif()
  endif()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libqhull.7.2.0.dylib;/usr/local/lib/libqhull.7.dylib;/usr/local/lib/libqhull.dylib")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE SHARED_LIBRARY FILES
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhull.7.2.0.dylib"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhull.7.dylib"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhull.dylib"
    )
  foreach(file
      "$ENV{DESTDIR}/usr/local/lib/libqhull.7.2.0.dylib"
      "$ENV{DESTDIR}/usr/local/lib/libqhull.7.dylib"
      "$ENV{DESTDIR}/usr/local/lib/libqhull.dylib"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      execute_process(COMMAND "/opt/local/bin/install_name_tool"
        -id "/usr/local/lib/libqhull.7.dylib"
        "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/libqhull_p.7.2.0.dylib;/usr/local/lib/libqhull_p.7.dylib;/usr/local/lib/libqhull_p.dylib")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/lib" TYPE SHARED_LIBRARY FILES
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhull_p.7.2.0.dylib"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhull_p.7.dylib"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/libqhull_p.dylib"
    )
  foreach(file
      "$ENV{DESTDIR}/usr/local/lib/libqhull_p.7.2.0.dylib"
      "$ENV{DESTDIR}/usr/local/lib/libqhull_p.7.dylib"
      "$ENV{DESTDIR}/usr/local/lib/libqhull_p.dylib"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      execute_process(COMMAND "/opt/local/bin/install_name_tool"
        -id "/usr/local/lib/libqhull_p.7.dylib"
        "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/libqhull/libqhull.h;/usr/local/include/libqhull/geom.h;/usr/local/include/libqhull/io.h;/usr/local/include/libqhull/mem.h;/usr/local/include/libqhull/merge.h;/usr/local/include/libqhull/poly.h;/usr/local/include/libqhull/qhull_a.h;/usr/local/include/libqhull/qset.h;/usr/local/include/libqhull/random.h;/usr/local/include/libqhull/stat.h;/usr/local/include/libqhull/user.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/libqhull" TYPE FILE FILES
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/libqhull.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/geom.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/io.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/mem.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/merge.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/poly.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qhull_a.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qset.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/random.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/stat.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/user.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/libqhull/index.htm;/usr/local/include/libqhull/qh-geom.htm;/usr/local/include/libqhull/qh-globa.htm;/usr/local/include/libqhull/qh-io.htm;/usr/local/include/libqhull/qh-mem.htm;/usr/local/include/libqhull/qh-merge.htm;/usr/local/include/libqhull/qh-poly.htm;/usr/local/include/libqhull/qh-qhull.htm;/usr/local/include/libqhull/qh-set.htm;/usr/local/include/libqhull/qh-stat.htm;/usr/local/include/libqhull/qh-user.htm;/usr/local/include/libqhull/DEPRECATED.txt")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/libqhull" TYPE FILE FILES
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/index.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-geom.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-globa.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-io.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-mem.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-merge.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-poly.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-qhull.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-set.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-stat.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/qh-user.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull/DEPRECATED.txt"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/libqhull_r/libqhull_r.h;/usr/local/include/libqhull_r/geom_r.h;/usr/local/include/libqhull_r/io_r.h;/usr/local/include/libqhull_r/mem_r.h;/usr/local/include/libqhull_r/merge_r.h;/usr/local/include/libqhull_r/poly_r.h;/usr/local/include/libqhull_r/qhull_ra.h;/usr/local/include/libqhull_r/qset_r.h;/usr/local/include/libqhull_r/random_r.h;/usr/local/include/libqhull_r/stat_r.h;/usr/local/include/libqhull_r/user_r.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/libqhull_r" TYPE FILE FILES
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/libqhull_r.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/geom_r.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/io_r.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/mem_r.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/merge_r.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/poly_r.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qhull_ra.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qset_r.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/random_r.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/stat_r.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/user_r.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/libqhull_r/index.htm;/usr/local/include/libqhull_r/qh-geom_r.htm;/usr/local/include/libqhull_r/qh-globa_r.htm;/usr/local/include/libqhull_r/qh-io_r.htm;/usr/local/include/libqhull_r/qh-mem_r.htm;/usr/local/include/libqhull_r/qh-merge_r.htm;/usr/local/include/libqhull_r/qh-poly_r.htm;/usr/local/include/libqhull_r/qh-qhull_r.htm;/usr/local/include/libqhull_r/qh-set_r.htm;/usr/local/include/libqhull_r/qh-stat_r.htm;/usr/local/include/libqhull_r/qh-user_r.htm")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/libqhull_r" TYPE FILE FILES
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/index.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-geom_r.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-globa_r.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-io_r.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-mem_r.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-merge_r.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-poly_r.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-qhull_r.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-set_r.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-stat_r.htm"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhull_r/qh-user_r.htm"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/include/libqhullcpp/Coordinates.h;/usr/local/include/libqhullcpp/functionObjects.h;/usr/local/include/libqhullcpp/PointCoordinates.h;/usr/local/include/libqhullcpp/Qhull.h;/usr/local/include/libqhullcpp/QhullError.h;/usr/local/include/libqhullcpp/QhullFacet.h;/usr/local/include/libqhullcpp/QhullFacetList.h;/usr/local/include/libqhullcpp/QhullFacetSet.h;/usr/local/include/libqhullcpp/QhullHyperplane.h;/usr/local/include/libqhullcpp/QhullIterator.h;/usr/local/include/libqhullcpp/QhullLinkedList.h;/usr/local/include/libqhullcpp/QhullPoint.h;/usr/local/include/libqhullcpp/QhullPoints.h;/usr/local/include/libqhullcpp/QhullPointSet.h;/usr/local/include/libqhullcpp/QhullQh.h;/usr/local/include/libqhullcpp/QhullRidge.h;/usr/local/include/libqhullcpp/QhullSet.h;/usr/local/include/libqhullcpp/QhullSets.h;/usr/local/include/libqhullcpp/QhullStat.h;/usr/local/include/libqhullcpp/QhullVertex.h;/usr/local/include/libqhullcpp/QhullVertexSet.h;/usr/local/include/libqhullcpp/RboxPoints.h;/usr/local/include/libqhullcpp/RoadError.h;/usr/local/include/libqhullcpp/RoadLogEvent.h;/usr/local/include/libqhullcpp/RoadTest.h")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/include/libqhullcpp" TYPE FILE FILES
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/Coordinates.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/functionObjects.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/PointCoordinates.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/Qhull.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullError.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullFacet.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullFacetList.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullFacetSet.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullHyperplane.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullIterator.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullLinkedList.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullPoint.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullPoints.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullPointSet.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullQh.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullRidge.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullSet.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullSets.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullStat.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullVertex.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/QhullVertexSet.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/RboxPoints.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/RoadError.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/libqhullcpp/RoadLogEvent.h"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/src/qhulltest/RoadTest.h"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/share/man/man1/qhull.1")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/share/man/man1" TYPE FILE RENAME "qhull.1" FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/html/qhull.man")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/share/man/man1/rbox.1")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/share/man/man1" TYPE FILE RENAME "rbox.1" FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/html/rbox.man")
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/share/doc/qhull/README.txt;/usr/local/share/doc/qhull/REGISTER.txt;/usr/local/share/doc/qhull/Announce.txt;/usr/local/share/doc/qhull/COPYING.txt;/usr/local/share/doc/qhull/index.htm")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/share/doc/qhull" TYPE FILE FILES
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/README.txt"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/REGISTER.txt"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/Announce.txt"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/COPYING.txt"
    "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/index.htm"
    )
endif()

if("${CMAKE_INSTALL_COMPONENT}" STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/share/doc/qhull/")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/share/doc/qhull" TYPE DIRECTORY FILES "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/html/")
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/Users/haifa/curvilinear-methods/lib/qhull-2015.2/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
