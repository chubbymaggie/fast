cmake_minimum_required(VERSION 2.8)

project(fast)

option(FAST_INSTALL "Enable the installation of targets." ON)
option(FAST_BUILD_FAST "Enable the build of the fast compiler" ON)

set(FAST_SRCS
  fast.cc
  fast.pb.cc
  fast.pb.h
  fast_generated.h
  rapidxml/rapidxml.hpp
  rapidxml/rapidxml_iterators.hpp
  rapidxml/rapidxml_print.hpp
  rapidxml/rapidxml_utils.hpp
)

if(EXISTS "${CMAKE_TOOLCHAIN_FILE}")
  # do not apply any global settings if the toolchain
  # is being configured externally
elseif(APPLE)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -stdlib=libc++")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic -Wextra")
elseif(CMAKE_COMPILER_IS_GNUCXX)
  if(CYGWIN)
    set(CMAKE_CXX_FLAGS
      "${CMAKE_CXX_FLAGS} -std=gnu++11")
  else(CYGWIN)
    set(CMAKE_CXX_FLAGS
      "${CMAKE_CXX_FLAGS} -std=c++0x")
  endif(CYGWIN)
  set(CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -Wall -pedantic -Werror -Wextra -Werror=shadow")
  if (GCC_VERSION VERSION_GREATER 4.4)
    set(CMAKE_CXX_FLAGS
      "${CMAKE_CXX_FLAGS} -Wunused-result -Werror=unused-result \
                          -Wunused-parameter -Werror=unused-parameter")
  endif()

  # Certain platforms such as ARM do not use signed chars by default
  # which causes issues with certain bounds checks.
  set(CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -fsigned-char")

elseif(${CMAKE_CXX_COMPILER_ID} MATCHES "Clang")
  set(CMAKE_CXX_FLAGS
      "${CMAKE_CXX_FLAGS} -std=c++0x -Wall -pedantic -Werror \
                          -Wextra")
  if(NOT "${CMAKE_SYSTEM_NAME}" MATCHES "Linux")
    set(CMAKE_CXX_FLAGS
        "${CMAKE_CXX_FLAGS} -stdlib=libc++")
  endif()
  if(NOT ("${CMAKE_SYSTEM_NAME}" MATCHES "FreeBSD" OR
          "${CMAKE_SYSTEM_NAME}" MATCHES "Linux"))
    set(CMAKE_EXE_LINKER_FLAGS
        "${CMAKE_EXE_LINKER_FLAGS} -lc++abi")
  endif()

  # Certain platforms such as ARM do not use signed chars by default
  # which causes issues with certain bounds checks.
  set(CMAKE_CXX_FLAGS
    "${CMAKE_CXX_FLAGS} -fsigned-char")

elseif(MSVC)
  # Visual Studio pedantic build settings
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4 /WX")
endif()

include_directories(rapidxml)
find_package(Protobuf REQUIRED)
include_directories(${PROTOBUF_INCLUDE_DIRS})
link_libraries(${PROTOBUF_LIBRARIES})


if(FAST_BUILD_FAST)
  add_executable(fast ${FAST_SRCS})
  if(NOT FAST_FAST_EXECUTABLE)
    set(FAST_FAST_EXECUTABLE $<TARGET_FILE:fast>)
  endif()
endif()

if(FAST_INSTALL)
  if(FAST_BUILD_FAST)
    install(TARGETS fast DESTINATION bin)
  endif()
endif()
