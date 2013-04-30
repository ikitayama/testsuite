# CMakeLists for dyninst/gcc/32/dyn/pic/none
set (CMAKE_C_FLAGS "-g -I${PROJECT_SOURCE_DIR}/testsuite/src -I${PROJECT_SOURCE_DIR}/testsuite/src/dyninst ${MUTATOR_DEFINES}  ${CFLAGS} -DSOLO_MUTATEE ${MUTATEE_CFLAGS_GNU}    -fPIC")
set (CMAKE_C_FLAGS_DEBUG "")
set (CMAKE_C_FLAGS_RELEASE "")
set (CMAKE_C_COMPILER "${M_gnu_cc}")
set (CMAKE_CXX_FLAGS ${CMAKE_C_FLAGS})
set (CMAKE_CXX_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
set (CMAKE_CXX_FLAGS_RELEASE ${CMAKE_C_FLAGS_RELEASE})
set (CMAKE_CXX_COMPILER ${CMAKE_C_COMPILER})
set (CMAKE_EXE_LINKER_FLAGS "${MUTATEE_LDFLAGS_GNU}  -Wl,-export-dynamic")
set (CMAKE_SHARED_LIBRARY_LINK_C_FLAGS )
set (CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS )
include (../../../../../../srclists.cmake)
add_executable (dyninst_group_test.dyn_gcc_32_pic_none ${SOURCE_LIST_60})
target_link_libraries (dyninst_group_test.dyn_gcc_32_pic_none dl)
add_executable (init_fini_callback.dyn_gcc_32_pic_none ${SOURCE_LIST_71})
target_link_libraries (init_fini_callback.dyn_gcc_32_pic_none dl)
add_executable (test1_12.dyn_gcc_32_pic_none ${SOURCE_LIST_75})
add_executable (test1_14.dyn_gcc_32_pic_none ${SOURCE_LIST_67})
add_executable (test1_19.dyn_gcc_32_pic_none ${SOURCE_LIST_33})
add_executable (test1_29.dyn_gcc_32_pic_none ${SOURCE_LIST_55})
add_executable (test1_35.dyn_gcc_32_pic_none ${SOURCE_LIST_89})
add_executable (test1_40.dyn_gcc_32_pic_none ${SOURCE_LIST_41})
add_executable (test1_41.dyn_gcc_32_pic_none ${SOURCE_LIST_81})
add_executable (test2_14.dyn_gcc_32_pic_none ${SOURCE_LIST_72})
add_executable (test2_6.dyn_gcc_32_pic_none ${SOURCE_LIST_0})
target_link_libraries (test2_6.dyn_gcc_32_pic_none dl)
add_executable (test2_8.dyn_gcc_32_pic_none ${SOURCE_LIST_62})
add_executable (test3_1.dyn_gcc_32_pic_none ${SOURCE_LIST_37})
add_executable (test3_2.dyn_gcc_32_pic_none ${SOURCE_LIST_40})
add_executable (test3_3.dyn_gcc_32_pic_none ${SOURCE_LIST_94})
add_executable (test3_4.dyn_gcc_32_pic_none ${SOURCE_LIST_49})
add_executable (test3_5.dyn_gcc_32_pic_none ${SOURCE_LIST_93})
add_executable (test3_6.dyn_gcc_32_pic_none ${SOURCE_LIST_28})
add_executable (test3_7.dyn_gcc_32_pic_none ${SOURCE_LIST_80})
add_executable (test4_1.dyn_gcc_32_pic_none ${SOURCE_LIST_1})
add_executable (test4_2.dyn_gcc_32_pic_none ${SOURCE_LIST_51})
add_executable (test4_3.dyn_gcc_32_pic_none ${SOURCE_LIST_100})
add_executable (test4_3b.dyn_gcc_32_pic_none ${SOURCE_LIST_27})
add_executable (test4_4.dyn_gcc_32_pic_none ${SOURCE_LIST_44})
add_executable (test4_4b.dyn_gcc_32_pic_none ${SOURCE_LIST_65})
add_executable (test_callback_1.dyn_gcc_32_pic_none ${SOURCE_LIST_59})
add_executable (test_callback_2.dyn_gcc_32_pic_none ${SOURCE_LIST_64})
add_executable (test_fork_10.dyn_gcc_32_pic_none ${SOURCE_LIST_68})
add_executable (test_fork_11.dyn_gcc_32_pic_none ${SOURCE_LIST_86})
add_executable (test_fork_12.dyn_gcc_32_pic_none ${SOURCE_LIST_7})
add_executable (test_fork_13.dyn_gcc_32_pic_none ${SOURCE_LIST_56})
add_executable (test_fork_5.dyn_gcc_32_pic_none ${SOURCE_LIST_24})
add_executable (test_fork_6.dyn_gcc_32_pic_none ${SOURCE_LIST_8})
add_executable (test_fork_7.dyn_gcc_32_pic_none ${SOURCE_LIST_34})
add_executable (test_fork_8.dyn_gcc_32_pic_none ${SOURCE_LIST_21})
add_executable (test_fork_9.dyn_gcc_32_pic_none ${SOURCE_LIST_42})
add_executable (test_mem_1.dyn_gcc_32_pic_none ${SOURCE_LIST_79})
add_executable (test_mem_2.dyn_gcc_32_pic_none ${SOURCE_LIST_52})
add_executable (test_mem_3.dyn_gcc_32_pic_none ${SOURCE_LIST_31})
add_executable (test_mem_4.dyn_gcc_32_pic_none ${SOURCE_LIST_6})
add_executable (test_mem_5.dyn_gcc_32_pic_none ${SOURCE_LIST_90})
add_executable (test_mem_6.dyn_gcc_32_pic_none ${SOURCE_LIST_101})
add_executable (test_mem_7.dyn_gcc_32_pic_none ${SOURCE_LIST_13})
add_executable (test_mem_8.dyn_gcc_32_pic_none ${SOURCE_LIST_92})
add_executable (test_snip_remove.dyn_gcc_32_pic_none ${SOURCE_LIST_69})
add_executable (test_stack_1.dyn_gcc_32_pic_none ${SOURCE_LIST_22})
add_executable (test_stack_2.dyn_gcc_32_pic_none ${SOURCE_LIST_23})
add_executable (test_stack_3.dyn_gcc_32_pic_none ${SOURCE_LIST_96})
add_executable (test_stack_4.dyn_gcc_32_pic_none ${SOURCE_LIST_83})
add_executable (test_thread_1.dyn_gcc_32_pic_none ${SOURCE_LIST_16})
target_link_libraries (test_thread_1.dyn_gcc_32_pic_none dl pthread)
add_executable (test_thread_2.dyn_gcc_32_pic_none ${SOURCE_LIST_88})
target_link_libraries (test_thread_2.dyn_gcc_32_pic_none dl pthread)
add_executable (test_thread_3.dyn_gcc_32_pic_none ${SOURCE_LIST_58})
target_link_libraries (test_thread_3.dyn_gcc_32_pic_none dl pthread)
add_executable (test_thread_5.dyn_gcc_32_pic_none ${SOURCE_LIST_84})
target_link_libraries (test_thread_5.dyn_gcc_32_pic_none dl pthread)
add_executable (test_thread_6.dyn_gcc_32_pic_none ${SOURCE_LIST_30})
target_link_libraries (test_thread_6.dyn_gcc_32_pic_none pthread)
add_executable (test_thread_7.dyn_gcc_32_pic_none ${SOURCE_LIST_25})
target_link_libraries (test_thread_7.dyn_gcc_32_pic_none pthread)
add_executable (test_thread_8.dyn_gcc_32_pic_none ${SOURCE_LIST_5})
target_link_libraries (test_thread_8.dyn_gcc_32_pic_none pthread)


INSTALL (TARGETS
		dyninst_group_test.dyn_gcc_32_pic_none
		init_fini_callback.dyn_gcc_32_pic_none
		test1_12.dyn_gcc_32_pic_none
		test1_14.dyn_gcc_32_pic_none
		test1_19.dyn_gcc_32_pic_none
		test1_29.dyn_gcc_32_pic_none
		test1_35.dyn_gcc_32_pic_none
		test1_40.dyn_gcc_32_pic_none
		test1_41.dyn_gcc_32_pic_none
		test2_14.dyn_gcc_32_pic_none
		test2_6.dyn_gcc_32_pic_none
		test2_8.dyn_gcc_32_pic_none
		test3_1.dyn_gcc_32_pic_none
		test3_2.dyn_gcc_32_pic_none
		test3_3.dyn_gcc_32_pic_none
		test3_4.dyn_gcc_32_pic_none
		test3_5.dyn_gcc_32_pic_none
		test3_6.dyn_gcc_32_pic_none
		test3_7.dyn_gcc_32_pic_none
		test4_1.dyn_gcc_32_pic_none
		test4_2.dyn_gcc_32_pic_none
		test4_3.dyn_gcc_32_pic_none
		test4_3b.dyn_gcc_32_pic_none
		test4_4.dyn_gcc_32_pic_none
		test4_4b.dyn_gcc_32_pic_none
		test_callback_1.dyn_gcc_32_pic_none
		test_callback_2.dyn_gcc_32_pic_none
		test_fork_10.dyn_gcc_32_pic_none
		test_fork_11.dyn_gcc_32_pic_none
		test_fork_12.dyn_gcc_32_pic_none
		test_fork_13.dyn_gcc_32_pic_none
		test_fork_5.dyn_gcc_32_pic_none
		test_fork_6.dyn_gcc_32_pic_none
		test_fork_7.dyn_gcc_32_pic_none
		test_fork_8.dyn_gcc_32_pic_none
		test_fork_9.dyn_gcc_32_pic_none
		test_mem_1.dyn_gcc_32_pic_none
		test_mem_2.dyn_gcc_32_pic_none
		test_mem_3.dyn_gcc_32_pic_none
		test_mem_4.dyn_gcc_32_pic_none
		test_mem_5.dyn_gcc_32_pic_none
		test_mem_6.dyn_gcc_32_pic_none
		test_mem_7.dyn_gcc_32_pic_none
		test_mem_8.dyn_gcc_32_pic_none
		test_snip_remove.dyn_gcc_32_pic_none
		test_stack_1.dyn_gcc_32_pic_none
		test_stack_2.dyn_gcc_32_pic_none
		test_stack_3.dyn_gcc_32_pic_none
		test_stack_4.dyn_gcc_32_pic_none
		test_thread_1.dyn_gcc_32_pic_none
		test_thread_2.dyn_gcc_32_pic_none
		test_thread_3.dyn_gcc_32_pic_none
		test_thread_5.dyn_gcc_32_pic_none
		test_thread_6.dyn_gcc_32_pic_none
		test_thread_7.dyn_gcc_32_pic_none
		test_thread_8.dyn_gcc_32_pic_none
	DESTINATION ${INSTALL_DIR})
