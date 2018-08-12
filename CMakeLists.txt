add_library(cint SHARED c.c)
add_executable(cso c_main.c)
add_executable(cfn c_func.c)
target_link_libraries(cso dl)

if(CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_CXX_FLAGS "-O2")        ## Optimize
endif()
