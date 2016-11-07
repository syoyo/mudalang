#!/usr/bin/env python

import os, sys
import subprocess
import re
import getopt

#
# Config
#
# mudahCmd = ".." + os.path.sep + "mudah --sse"
# compiler = "gcc -c -msse2"

# mudahCmd = ".." + os.path.sep + "mudah --vmx"
# compiler = "gcc -c -maltivec"

# mudahCmd = ".." + os.path.sep + "mudah --llvm"
# compiler = "llvm-as -f"

cmds = {}
cmds["sse"]  = (".." + os.path.sep + "mudah --sse", "gcc -I. -I../include -c -msse2")
cmds["vmx"]  = (".." + os.path.sep + "mudah --vmx", "gcc -I. -I../incluee -c -maltivec")
cmds["llvm"] = (".." + os.path.sep + "mudah --llvm", "llvm-as -f")

backend = "sse"

def usage():
    print """
./tester.py <opts>

  opts:

    --sse       : Test for SSE2 backend
    --vmx       : Test for VMX backend
    --llvm      : Test for LLVM backend
"""

#
# Parse args
#
try:
    opts, args = getopt.getopt(sys.argv[1:], "", ["sse", "vmx", "llvm", "help"])
except getopt.GetoptError:
    usage()
    sys.exit(2)

for o, a in opts:

    if o == "--sse":
        backend = "sse"

    if o == "--vmx":
        backend = "vmx"

    if o == "--llvm":
        backend = "llvm"

    if o == "--help":
        usage()
        sys.exit(1)


print "TEST MSG: Using backend : ", backend

files = os.popen('ls *.mu').read().split();

nOKs = 0;
nNGs = 0;

total = len(files);

mudahCmd = cmds[backend][0]
compiler = cmds[backend][1]

i = -1;
for f in files:

	i = i + 1;

	root, ext = os.path.splitext(f);
	logname = root + ".out.c";


	cmd = mudahCmd + " " + f + " 2> " + os.devnull + " > " + logname;

	print "(%3d of %3d) Testing [ %-20s ] ... " % ( i, total, f),

	ret = subprocess.call(cmd, shell=True);

	if ret != 0:
		print "Fail";
		nNGs += 1
		continue;

	#
	# Check output
	#
	cmd = "cat " + logname;
	content = os.popen(cmd).read();

	if re.search("Parse error", content):
		print "Failed parsing";
		continue;

	#
	# Check compile	
	#
	cmd = compiler + " " + logname

	ret = subprocess.call(cmd, shell=True);

	if ret != 0:
		print "Failed compilation";
		nNGs = nNGs + 1;
		continue;

	nOKs = nOKs + 1;

	print "OK";

	
print "======================================================="
print "%d Passed, %d Failed" % (nOKs, nNGs)

	
