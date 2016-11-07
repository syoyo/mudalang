#!/usr/bin/env python

import os, sys

sys.path.append("../common")

# import from ../common
import genx86
import genvalue

#
# cornerTests
# (name, val)
#
corners = [
       ("+0.0", genvalue.kPositiveZero)
     , ("-0.0", genvalue.kNegativeZero)
     , ("+Inf", genvalue.kPositiveInf)
     , ("-Inf", genvalue.kNegativeInf)
     , ("+NaN", genvalue.kPositiveQNaN)
     , ("-NaN", genvalue.kNegativeQNaN)
]    
    

doFullTest = True
doNegTest  = False


genx86.emitTestCode("expmu", "expf", (doFullTest, doNegTest), corners)

