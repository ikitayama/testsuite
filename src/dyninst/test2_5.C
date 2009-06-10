/*
 * Copyright (c) 1996-2004 Barton P. Miller
 * 
 * We provide the Paradyn Parallel Performance Tools (below
 * described as "Paradyn") on an AS IS basis, and do not warrant its
 * validity or performance.  We reserve the right to update, modify,
 * or discontinue this software at any time.  We shall have no
 * obligation to supply such updates or modifications or any other
 * form of support to you.
 * 
 * This license is for research uses.  For such uses, there is no
 * charge. We define "research use" to mean you may freely use it
 * inside your organization for whatever purposes you see fit. But you
 * may not re-distribute Paradyn or parts of Paradyn, in any form
 * source or binary (including derivatives), electronic or otherwise,
 * to any other organization or entity without our permission.
 * 
 * (for other uses, please contact us at paradyn@cs.wisc.edu)
 * 
 * All warranties, including without limitation, any warranty of
 * merchantability or fitness for a particular purpose, are hereby
 * excluded.
 * 
 * By your use of Paradyn, you understand and agree that we (or any
 * other person or entity with proprietary rights in Paradyn) are
 * under no obligation to provide either maintenance services,
 * update services, notices of latent defects, or correction of
 * defects for Paradyn.
 * 
 * Even if advised of the possibility of such damages, under no
 * circumstances shall we (or any other person or entity with
 * proprietary rights in the software licensed hereunder) be liable
 * to you or any third party for direct, indirect, or consequential
 * damages of any character regardless of type of action, including,
 * without limitation, loss of profits, loss of use, loss of good
 * will, or computer failure or malfunction.  You agree to indemnify
 * us (and any other person or entity with proprietary rights in the
 * software licensed hereunder) for any and all liability it may
 * incur to third parties resulting from your use of Paradyn.
 */

// $Id: test2_5.C,v 1.1 2008/10/30 19:20:23 legendre Exp $
/*
 * #Name: test2_5
 * #Desc: Look up nonexistent function
 * #Dep: 
 * #Arch:
 * #Notes:
 */

#include "BPatch.h"
#include "BPatch_Vector.h"
#include "BPatch_thread.h"
#include "BPatch_snippet.h"

#include "test_lib.h"
#include "Callbacks.h"

#include "dyninst_comp.h"
class test2_5_Mutator : public DyninstMutator {
  virtual test_results_t executeTest();
};
extern "C" DLLEXPORT  TestMutator *test2_5_factory() {
  return new test2_5_Mutator();
}

//
// Test #5 - look up nonexistent function)
//	Try to call findFunction on a function that is not defined for the
//	process.
//
// static int mutatorTest(BPatch_thread *appThread, BPatch_image *img)
test_results_t test2_5_Mutator::executeTest()
{
    test_results_t result;
    clearError();
    /*
    expectErrors = true; // test #5 causes error #100 (Unable to find function)
    expectErrors = false;
    */
    setExpectError(100); // test #5 causes error #100 (Unable to find function)

    BPatch_Vector<BPatch_function *> bpfv, *res;
    char *fn = "NoSuchFunction";
    // logerror("Looking for function\n");
    if (!(NULL == (res=appImage->findFunction(fn, bpfv)) || !bpfv.size()
	|| NULL == bpfv[0]) || !getError()){
      logerror("**Failed** test #5 (look up nonexistent function)\n");
      if (res)
	logerror("    non-null for findFunction on non-existant func\n");
      if (!getError())
	logerror("    the error callback should have been called but wasn't\n");
      result = FAILED;
    } else {
	logerror("Passed test #5 (look up nonexistent function)\n");
        result = PASSED;
    }

    setExpectError(DYNINST_NO_ERROR);

    // Let the mutatee continue
    BPatch_variableExpr *expr5_1 =
      appImage->findVariable("test2_5_spinning");
    if (expr5_1 == NULL) {
      logerror("**Failed** test #5 (look up nonexistent function)\n");
      logerror("    Unable to locate test2_5_spinning\n");
      result = FAILED;
    } 
    int pvalue = 0;
    expr5_1->writeValue(&pvalue);

    return result;
}

// extern "C" TEST_DLL_EXPORT int test2_5_mutatorMAIN(ParameterDict &param)
// {
//     bool useAttach = param["useAttach"]->getInt();
//     BPatch *bpatch = (BPatch *)(param["bpatch"]->getPtr());

//     BPatch_thread *appThread = (BPatch_thread *)(param["appThread"]->getPtr());

//     // Read the program's image and get an associated image object
//     BPatch_image *appImage = appThread->getImage();

//     // Get log file pointers
//     FILE *outlog = (FILE *)(param["outlog"]->getPtr());
//     FILE *errlog = (FILE *)(param["errlog"]->getPtr());
//     setOutputLog(outlog);
//     setErrorLog(errlog);

//     // Signal the child that we've attached
//     if (useAttach) {
// 	signalAttached(appThread, appImage);
//     }

//     // This calls the actual test to instrument the mutatee
//     return mutatorTest(appThread, appImage);
// }