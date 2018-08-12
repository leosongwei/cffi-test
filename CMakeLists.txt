add_library(cint SHARED c.c)
add_executable(a.out c_main.c)
target_link_libraries(a.out dl)

if(CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_CXX_FLAGS "-O2")        ## Optimize
endif()
