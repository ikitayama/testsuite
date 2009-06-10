#include "cpp_test.h"
#include "mutatee_util.h"

/* group_mutatee_boilerplate.c is prepended to this file by the make system */

/* Externally accessed function prototypes.  These must have globally unique
 * names.  I suggest following the pattern <testname>_<function>
 */

/* Global variables accessed by the mutator.  These must have globally unique
 * names.
 */

/* Internally used function prototypes.  These should be declared with the
 * keyword static so they don't interfere with other mutatees in the group.
 */

/* Global variables used internally by the mutatee.  These should be declared
 * with the keyword static so they don't interfere with other mutatees in the
 * group.
 */

static int passed = 0;
decl_test test5_8_test8;
static int inst_called = false;

/* Function definitions follow */

void decl_test::func_cpp()
{
   int CPP_DEFLT_ARG = 8;

   if ( 8 != CPP_DEFLT_ARG )
     logerror("CPP_DEFLT_ARG init value wrong\n");
   if ( 1024 != ::CPP_DEFLT_ARG )
     logerror("::CPP_DEFLT_ARG init value wrong\n");
   if ( 0 != cpp_test_util::CPP_TEST_UTIL_VAR )
     logerror("cpp_test_util::CPP_TEST_UTIL_VAR int value wrong\n");
}

// A call to this is inserted by the mutator when its analysis succeeds (test
// passes)
void decl_test::call_cpp(int test)
{
  inst_called = true;
   if (test != 8) {
     logerror("**Failed** test #8 (C++ argument pass)\n");
     logerror("    Pass in an incorrect parameter value\n");
     return;
   }
   // Why do we do this assignment?
//    cpp_test_util::CPP_TEST_UTIL_VAR = ::CPP_DEFLT_ARG;
//    cpp_test_util::call_cpp(test);
   passed = 1;
}

int test5_8_mutatee() {
  test5_8_test8.func_cpp();
  if (1 == passed) {
    // Test passed
    logstatus("Passed test #8 (declaration)\n");
    test_passes(testname);
    return 0;
  } else {
    if (!inst_called) {
      logerror("**Failed test #8 (declaration)\n");
      logerror("    Instrumentation not called\n");
    }
    // Test failed
    return -1;
  }
}