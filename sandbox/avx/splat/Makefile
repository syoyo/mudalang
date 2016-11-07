all:
	gcc-avx -mavx -S splat.c
	yasm -f elf -p gas splat.s
	gcc-avx splat.o
