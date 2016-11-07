#!/usr/bin/env python

import os, sys

sys.path.append("../common")

import genx86

doFullTest = False
doNegTest  = True

doRangeCheck = True
startRange   = 0.0
endRange     = 31.5
stepVal      = 0.000001

genx86.emitTestCode("cosmu", "cosf", (doFullTest, doNegTest), (doRangeCheck, startRange, endRange, stepVal))

