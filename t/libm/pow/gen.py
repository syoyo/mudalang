#!/usr/bin/env python

import os, sys

sys.path.append("../common")

import genx86

doNegTest = True

genx86.emitTestCode("powmu", "powf", doNegTest)

