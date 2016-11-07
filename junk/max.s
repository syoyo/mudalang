

	.text
	.align	16
	.globl	muda_maxf4
	.type	muda_maxf4,@function
muda_maxf4:
	extractps	$3, %xmm1, %xmm2
	extractps	$3, %xmm0, %xmm3
	ucomiss	%xmm2, %xmm3
	ja	.LBB1_2	# 
.LBB1_1:	# 
	movaps	%xmm2, %xmm3
.LBB1_2:	# 
	extractps	$1, %xmm1, %xmm2
	extractps	$1, %xmm0, %xmm4
	ucomiss	%xmm2, %xmm4
	ja	.LBB1_4	# 
.LBB1_3:	# 
	movaps	%xmm2, %xmm4
.LBB1_4:	# 
	movss	%xmm4, %xmm2
	unpcklps	%xmm3, %xmm2
	extractps	$2, %xmm1, %xmm3
	extractps	$2, %xmm0, %xmm4
	ucomiss	%xmm3, %xmm4
	ja	.LBB1_6	# 
.LBB1_5:	# 
	movaps	%xmm3, %xmm4
.LBB1_6:	# 
	ucomiss	%xmm1, %xmm0
	ja	.LBB1_8	# 
.LBB1_7:	# 
	movaps	%xmm1, %xmm0
.LBB1_8:	# 
	unpcklps	%xmm4, %xmm0
	unpcklps	%xmm2, %xmm0
	ret
	.size	muda_maxf4, .-muda_maxf4

