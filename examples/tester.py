#!/usr/bin/env python

import os;
import subprocess;
import re;

#
# Config
#
mudahCmd = ".." + os.path.sep + "mudah"
compiler = "gcc -c -msse2"

files = os.popen('ls *.mu').read().split();

nOKs = 0;
nNGs = 0;

total = len(files);

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

	
