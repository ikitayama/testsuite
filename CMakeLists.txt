cmake_minimum_required (VERSION 2.6)
project (Dyninst-TestSuite)

include (c++11.cmake)

find_package (Dyninst REQUIRED CONFIG)
message (STATUS "Dyninst includes: ${DYNINST_INCLUDE_DIR}")
include_directories (${DYNINST_INCLUDE_DIR})

set (BUILD_SHARED_LIBS ON)

set (INSTALL_DIR "bin/testsuite" CACHE PATH "Testsuite installation directory")

# Build rules for the test libraries (libtestdyninst, libtestproccontrol, etc.)
# and the executables

# We want to build assembly files with gcc
if (UNIX)
enable_language(ASM-ATT)
endif (UNIX)

foreach (def ${DYNINST_INTERNAL_DEFINES})
  # add_definitions doesn't seem to get pulled in; that's okay, since
  # we don't want it anyway (we want to override for mutators/ees)
  add_definitions (${def}_test)
  set (MUTATEE_DEFINES "${MUTATEE_DEFINES} ${def}_test")
endforeach()

include_directories (src
                    src/dyninst
                    src/proccontrol
                    src/symtab
                    src/instruction)

add_library (testSuite SHARED 
            src/test_lib.C 
            src/test_lib_soExecution.C
            src/TestData.C
            src/TestMutator.C
            src/TestOutputDriver.C
            src/StdOutputDriver.C
            src/remotetest.C
            src/connection.C
            src/module.C
            src/test_lib_templates.C)
target_link_libraries (testSuite dl)

add_library (testlaunch SHARED
            src/CmdLine.C
            src/ParameterDict.C
            src/ResumeLog.C
            src/MutateeStart.C
            src/test_info_new.C
            ${DYNINST_PLATFORM}/test_info_new.gen.C)
target_link_libraries (testlaunch)

add_library (testdyninst SHARED
            src/dyninst/dyninst_comp.C
            src/dyninst/test_lib_mutateeStart.C
            src/dyninst/Callbacks.C
            src/dyninst/Process_data.C
            src/dyninst/ParseThat.C
            src/dyninst/test_lib_test7.C
            src/dyninst/test_lib_test9.C)
target_link_libraries (testdyninst dyninstAPI pthread)

add_library (testsymtab SHARED
            src/symtab/symtab_comp.C)
target_link_libraries (testsymtab symtabAPI pthread)

add_library (testinstruction SHARED
            src/instruction/instruction_comp.C)
target_link_libraries (testinstruction instructionAPI symtabAPI pthread)

add_library (testproccontrol SHARED
            src/proccontrol/proccontrol_comp.C)
target_link_libraries (testproccontrol pcontrol pthread)

add_executable (runTests 
               src/runTests.C
               src/runTests-utils.C
               src/test_driver_templates.C)
target_link_libraries (runTests)

add_executable (test_driver
               src/test_driver.C
               src/test_driver_templates.C
               src/dynlmon.C
               src/testdriver_be.C
               ${DYNINST_PLATFORM}/test_info_new.gen.C)
target_link_libraries (test_driver testSuite testlaunch)


add_executable (testdriver_wrapper
               src/connection.C
               src/testdriver_wrapper.C)

install (TARGETS
        test_driver
        testdriver_wrapper
        runTests
        testSuite
        testlaunch
        testdyninst
        testsymtab
        testinstruction
        testproccontrol
        DESTINATION ${INSTALL_DIR})



include (${DYNINST_PLATFORM}/cmake-mutators.txt)

if (DYNINST_PLATFORM MATCHES "bgq")
FIND_PROGRAM(M_bg_cc NAMES mpixlc)
FIND_PROGRAM(M_bg_CC NAMES mpixlcxx)
FIND_PROGRAM(M_gnu_cc NAMES mpicc)
FIND_PROGRAM(M_gnu_xx NAMES mpicxx)
elseif (UNIX)
# Compiler macros
FIND_PROGRAM(M_gnu_cc NAMES gcc)
FIND_PROGRAM(M_gnu_cxx NAMES g++)
FIND_PROGRAM(M_intel_cc NAMES icc)
FIND_PROGRAM(M_intel_CC NAMES icpc)
FIND_PROGRAM(M_pg_cc NAMES pgcc)
FIND_PROGRAM(M_pg_cxx NAMES pgCC)
#TODO BG/Q
endif ()

include (checkMutateeCompiler.cmake)
include (${DYNINST_PLATFORM}/cmake-compilers.txt)

if (BUILD_LIBS_32)
add_library (testA_32 SHARED src/libtestA.c)
add_library (testB_32 SHARED src/libtestB.c)
add_library (Test12_32 SHARED src/dyninst/libTest12.c)
install (TARGETS testA_32 testB_32 Test12_32 LIBRARY DESTINATION ${INSTALL_DIR})

if (BUILD_LIBS_64)
set_target_properties (testA_32
                      PROPERTIES
                      COMPILE_FLAGS "-m32 -Dm32_test"
                      LINK_FLAGS "-m32")
set_target_properties (testB_32
                      PROPERTIES
                      COMPILE_FLAGS "-m32 -Dm32_test"
                      LINK_FLAGS "-m32")
set_target_properties (Test12_32
                      PROPERTIES
                      COMPILE_FLAGS "-m32 -Dm32_test"
                      LINK_FLAGS "-m32")
endif()
endif()

if (BUILD_LIBS_64)
add_library (testA_64 SHARED src/libtestA.c)
add_library (testB_64 SHARED src/libtestB.c)
add_library (Test12_64 SHARED src/dyninst/libTest12.c)
install (TARGETS testA_64 testB_64 Test12_64 LIBRARY DESTINATION ${INSTALL_DIR})
endif()



include (${DYNINST_PLATFORM}/cmake-mutatees.txt)

