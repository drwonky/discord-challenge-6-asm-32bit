/* ============================================================================
 * Name        : discord-challenge-6-asm.S
 * Author      : Perry Harrington
 * Version     :
 * Copyright   : Your copyright notice
 * Description : Discord challenge 6 in assembly, for Linux i686 (32bit)
 * compile with as --32 and link with -m32 or compile/link with gcc -m32
 * ============================================================================
 */

.equ SYS_read, 3
.equ SYS_write, 4
.equ nl, 10

.data
string:	.zero 12
a:		.ascii " \xff\xf9\xf1\xfe'r\xe9#\x9b%\x14\x1fI\xfd'\xff\xf1\x86\x17"
newline: .byte nl
i:		.long 0
j:		.long 0
k:		.long 0
slen:	.long 0

.text
.global main
main:
	mov		$string, %ecx
	mov		$12, %edx		# read up to 10 actual digits
	call	readline

	sub		$1, %eax
	mov		%eax, slen		# bytes read on stdin the trailing newline and \0 are included

	movl	$0, i			# for(i=0...)
eachline:
	movl	$0, j			# for(j=0...)

	mov		$newline, %ecx	# newline
	call	writechar		# print newline before line

foreachs:
	mov		$string, %edi

	mov		j, %esi
	movzxb	(%esi,%edi), %ecx
							#s=string[j]
	mov		$5, %edx
	mov		i, %eax
	imul	%eax, %edx		# i*5 (5 bytes per row of characters)

	sub		$48, %ecx		# j-48
	mov		%ecx, %ebx		# original ascii->num j in rcx
	shr		%ebx

	mov		$a, %edi

	add		%edx, %edi		# f=i*5
	add		%ebx, %edi		# f=f+(j/2)

	movzxb	(%edi), %esi	# rsi = a[f] overwrite j/2

	and		$1, %ecx		# j&1
	shl		$2, %ecx		# j*4

	shr		%cl, %esi		# a[f]>>(j&1)*4

	movl	$0, k			# for(k=0...)
eachchar:
	push	%esi			# save a[f], our bit pattern

	mov		k, %ecx
	shl		%cl, %esi		# rsi=(f<<k)&8
	and		$8, %esi

	mov		%esi, %ecx
	add		$a, %ecx		# esi demolished
							# load ' ' or '#'
	call	writechar

	pop		%esi			# restore j
	incl	k
	cmp		$4, k
	jle		eachchar		# for(...k<4;k++)

	incl	j				# for (j:string)
	mov		slen, %eax
	cmp		%eax, j
	jne		foreachs		# string len 1+string

	incl	i
	cmp		$3, i
	jle		eachline		# for (...i<4;i++)

	xor		%eax, %eax
	ret

writechar:
	mov		$SYS_write, %eax
	mov		$1, %ebx		# stdout
	mov		$1, %edx		# 1 byte to write
	int		$0x80
	ret

readline:
	mov		$SYS_read, %eax
	mov		$0, %ebx
	int		$0x80
	ret
