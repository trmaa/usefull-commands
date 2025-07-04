	.file	"snake.c"
	.text
	.globl	score
	.data
	.align 4
	.type	score, @object
	.size	score, 4
score:
	.long	1
	.globl	snake_length
	.align 4
	.type	snake_length, @object
	.size	snake_length, 4
snake_length:
	.long	3
	.globl	snake
	.bss
	.align 32
	.type	snake, @object
	.size	snake, 1152
snake:
	.zero	1152
	.globl	food
	.align 8
	.type	food, @object
	.size	food, 8
food:
	.zero	8
	.globl	direction
	.data
	.type	direction, @object
	.size	direction, 1
direction:
	.byte	97
	.globl	last_direction
	.type	last_direction, @object
	.size	last_direction, 1
last_direction:
	.byte	97
	.globl	game_over
	.bss
	.type	game_over, @object
	.size	game_over, 1
game_over:
	.zero	1
	.text
	.globl	disable_input_buffering
	.type	disable_input_buffering, @function
disable_input_buffering:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-80(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	tcgetattr@PLT
	movl	-68(%rbp), %eax
	andl	$-11, %eax
	movl	%eax, -68(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %esi
	movl	$0, %edi
	call	tcsetattr@PLT
	movl	$3, %esi
	movl	$0, %edi
	movl	$0, %eax
	call	fcntl@PLT
	orb	$8, %ah
	movl	%eax, %edx
	movl	$4, %esi
	movl	$0, %edi
	movl	$0, %eax
	call	fcntl@PLT
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L2
	call	__stack_chk_fail@PLT
.L2:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	disable_input_buffering, .-disable_input_buffering
	.globl	restore_input_buffering
	.type	restore_input_buffering, @function
restore_input_buffering:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-80(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	tcgetattr@PLT
	movl	-68(%rbp), %eax
	orl	$10, %eax
	movl	%eax, -68(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, %rdx
	movl	$0, %esi
	movl	$0, %edi
	call	tcsetattr@PLT
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L4
	call	__stack_chk_fail@PLT
.L4:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	restore_input_buffering, .-restore_input_buffering
	.section	.rodata
	.align 8
.LC0:
	.string	"\033[31mGame Over! Final Score: %d\n\033[0m"
	.text
	.globl	handle_game_over
	.type	handle_game_over, @function
handle_game_over:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	score(%rip), %eax
	leaq	.LC0(%rip), %rdx
	movl	%eax, %esi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movb	$1, game_over(%rip)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	handle_game_over, .-handle_game_over
	.globl	move_snake
	.type	move_snake, @function
move_snake:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	snake_length(%rip), %eax
	subl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.L7
.L8:
	movl	-8(%rbp), %eax
	leal	-1(%rax), %esi
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	snake(%rip), %rdx
	movslq	%esi, %rax
	leaq	0(,%rax,8), %rsi
	leaq	snake(%rip), %rax
	movq	(%rsi,%rax), %rax
	movq	%rax, (%rcx,%rdx)
	subl	$1, -8(%rbp)
.L7:
	cmpl	$0, -8(%rbp)
	jg	.L8
	movzbl	direction(%rip), %eax
	movsbl	%al, %eax
	cmpl	$119, %eax
	je	.L9
	cmpl	$119, %eax
	jg	.L10
	cmpl	$115, %eax
	je	.L11
	cmpl	$115, %eax
	jg	.L10
	cmpl	$97, %eax
	je	.L12
	cmpl	$100, %eax
	je	.L13
	jmp	.L10
.L9:
	movl	4+snake(%rip), %eax
	subl	$1, %eax
	movl	%eax, 4+snake(%rip)
	jmp	.L10
.L11:
	movl	4+snake(%rip), %eax
	addl	$1, %eax
	movl	%eax, 4+snake(%rip)
	jmp	.L10
.L12:
	movl	snake(%rip), %eax
	subl	$1, %eax
	movl	%eax, snake(%rip)
	jmp	.L10
.L13:
	movl	snake(%rip), %eax
	addl	$1, %eax
	movl	%eax, snake(%rip)
	nop
.L10:
	movl	snake(%rip), %eax
	testl	%eax, %eax
	js	.L14
	movl	snake(%rip), %eax
	cmpl	$11, %eax
	jg	.L14
	movl	4+snake(%rip), %eax
	testl	%eax, %eax
	js	.L14
	movl	4+snake(%rip), %eax
	cmpl	$11, %eax
	jle	.L15
.L14:
	call	handle_game_over
	jmp	.L6
.L15:
	movl	$1, -4(%rbp)
	jmp	.L17
.L19:
	movl	snake(%rip), %edx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	snake(%rip), %rax
	movl	(%rcx,%rax), %eax
	cmpl	%eax, %edx
	jne	.L18
	movl	4+snake(%rip), %edx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	4+snake(%rip), %rax
	movl	(%rcx,%rax), %eax
	cmpl	%eax, %edx
	jne	.L18
	call	handle_game_over
	jmp	.L6
.L18:
	addl	$1, -4(%rbp)
.L17:
	movl	snake_length(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L19
.L6:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	move_snake, .-move_snake
	.globl	check_food
	.type	check_food, @function
check_food:
.LFB10:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	snake(%rip), %edx
	movl	food(%rip), %eax
	cmpl	%eax, %edx
	jne	.L27
	movl	4+snake(%rip), %edx
	movl	4+food(%rip), %eax
	cmpl	%eax, %edx
	jne	.L27
	movl	snake_length(%rip), %eax
	leal	-1(%rax), %esi
	movl	snake_length(%rip), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	snake(%rip), %rdx
	movslq	%esi, %rax
	leaq	0(,%rax,8), %rsi
	leaq	snake(%rip), %rax
	movq	(%rsi,%rax), %rax
	movq	%rax, (%rcx,%rdx)
	movl	snake_length(%rip), %eax
	addl	$1, %eax
	movl	%eax, snake_length(%rip)
	movl	score(%rip), %eax
	addl	$1, %eax
	movl	%eax, score(%rip)
.L26:
	movb	$1, -5(%rbp)
	call	rand@PLT
	movl	%eax, %ecx
	movslq	%ecx, %rax
	imulq	$715827883, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %edx
	sarl	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movl	%edx, food(%rip)
	call	rand@PLT
	movl	%eax, %ecx
	movslq	%ecx, %rax
	imulq	$715827883, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %edx
	sarl	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movl	%edx, 4+food(%rip)
	movl	$0, -4(%rbp)
	jmp	.L22
.L25:
	movl	food(%rip), %edx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	snake(%rip), %rax
	movl	(%rcx,%rax), %eax
	cmpl	%eax, %edx
	jne	.L23
	movl	4+food(%rip), %edx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	4+snake(%rip), %rax
	movl	(%rcx,%rax), %eax
	cmpl	%eax, %edx
	jne	.L23
	movb	$0, -5(%rbp)
	jmp	.L24
.L23:
	addl	$1, -4(%rbp)
.L22:
	movl	snake_length(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L25
.L24:
	movzbl	-5(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	jne	.L26
.L27:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	check_food, .-check_food
	.section	.rodata
.LC1:
	.string	"clear"
.LC2:
	.base64	"G1szMm1PG1swbSAA"
.LC3:
	.base64	"G1szMm1vG1swbSAA"
.LC4:
	.base64	"G1szMW1AG1swbSAA"
.LC5:
	.string	". "
.LC6:
	.string	"\033[32mScore: %d\n\033[0m"
	.text
	.globl	draw_board
	.type	draw_board, @function
draw_board:
.LFB11:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	system@PLT
	movl	$0, -12(%rbp)
	jmp	.L29
.L40:
	movl	$0, -8(%rbp)
	jmp	.L30
.L39:
	movb	$0, -13(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L31
.L36:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	snake(%rip), %rax
	movl	(%rdx,%rax), %eax
	cmpl	%eax, -8(%rbp)
	jne	.L32
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	4+snake(%rip), %rax
	movl	(%rdx,%rax), %eax
	cmpl	%eax, -12(%rbp)
	jne	.L32
	cmpl	$0, -4(%rbp)
	jne	.L33
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L34
.L33:
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L34:
	movb	$1, -13(%rbp)
	jmp	.L35
.L32:
	addl	$1, -4(%rbp)
.L31:
	movl	snake_length(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L36
.L35:
	movzbl	-13(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L37
	movl	food(%rip), %eax
	cmpl	%eax, -8(%rbp)
	jne	.L38
	movl	4+food(%rip), %eax
	cmpl	%eax, -12(%rbp)
	jne	.L38
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L37
.L38:
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L37:
	addl	$1, -8(%rbp)
.L30:
	cmpl	$11, -8(%rbp)
	jle	.L39
	movl	$10, %edi
	call	putchar@PLT
	addl	$1, -12(%rbp)
.L29:
	cmpl	$11, -12(%rbp)
	jle	.L40
	movl	score(%rip), %eax
	leaq	.LC6(%rip), %rdx
	movl	%eax, %esi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	draw_board, .-draw_board
	.globl	process_input
	.type	process_input, @function
process_input:
.LFB12:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-9(%rbp), %rax
	movl	$1, %edx
	movq	%rax, %rsi
	movl	$0, %edi
	call	read@PLT
	testq	%rax, %rax
	jle	.L52
	movzbl	-9(%rbp), %eax
	movsbl	%al, %eax
	cmpl	$119, %eax
	je	.L43
	cmpl	$119, %eax
	jg	.L52
	cmpl	$115, %eax
	je	.L44
	cmpl	$115, %eax
	jg	.L52
	cmpl	$97, %eax
	je	.L45
	cmpl	$100, %eax
	je	.L46
	jmp	.L52
.L43:
	movzbl	last_direction(%rip), %eax
	cmpb	$115, %al
	je	.L53
	movzbl	-9(%rbp), %eax
	movb	%al, direction(%rip)
	movzbl	-9(%rbp), %eax
	movb	%al, last_direction(%rip)
	jmp	.L53
.L44:
	movzbl	last_direction(%rip), %eax
	cmpb	$119, %al
	je	.L54
	movzbl	-9(%rbp), %eax
	movb	%al, direction(%rip)
	movzbl	-9(%rbp), %eax
	movb	%al, last_direction(%rip)
	jmp	.L54
.L45:
	movzbl	last_direction(%rip), %eax
	cmpb	$100, %al
	je	.L55
	movzbl	-9(%rbp), %eax
	movb	%al, direction(%rip)
	movzbl	-9(%rbp), %eax
	movb	%al, last_direction(%rip)
	jmp	.L55
.L46:
	movzbl	last_direction(%rip), %eax
	cmpb	$97, %al
	je	.L56
	movzbl	-9(%rbp), %eax
	movb	%al, direction(%rip)
	movzbl	-9(%rbp), %eax
	movb	%al, last_direction(%rip)
	jmp	.L56
.L53:
	nop
	jmp	.L52
.L54:
	nop
	jmp	.L52
.L55:
	nop
	jmp	.L52
.L56:
	nop
.L52:
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L51
	call	__stack_chk_fail@PLT
.L51:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	process_input, .-process_input
	.section	.rodata
.LC7:
	.string	"\033[?25l"
	.text
	.globl	initialize_game
	.type	initialize_game, @function
initialize_game:
.LFB13:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L58
.L59:
	movl	-4(%rbp), %eax
	leal	6(%rax), %ecx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	snake(%rip), %rax
	movl	%ecx, (%rdx,%rax)
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	4+snake(%rip), %rax
	movl	$6, (%rdx,%rax)
	addl	$1, -4(%rbp)
.L58:
	cmpl	$2, -4(%rbp)
	jle	.L59
	call	rand@PLT
	movl	%eax, %ecx
	movslq	%ecx, %rax
	imulq	$715827883, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %edx
	sarl	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movl	%edx, food(%rip)
	call	rand@PLT
	movl	%eax, %ecx
	movslq	%ecx, %rax
	imulq	$715827883, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %edx
	sarl	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$2, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	movl	%edx, 4+food(%rip)
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	initialize_game, .-initialize_game
	.section	.rodata
.LC8:
	.string	"\033[?25h"
	.text
	.globl	cleanup
	.type	cleanup, @function
cleanup:
.LFB14:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	call	restore_input_buffering
	leaq	.LC8(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	cleanup, .-cleanup
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	call	initialize_game
	call	disable_input_buffering
	leaq	cleanup(%rip), %rax
	movq	%rax, %rdi
	call	atexit@PLT
	jmp	.L62
.L65:
	call	process_input
	call	check_food
	call	move_snake
	movzbl	game_over(%rip), %eax
	testb	%al, %al
	jne	.L67
	call	draw_board
	movl	$150000, %edi
	call	usleep@PLT
.L62:
	movzbl	game_over(%rip), %eax
	xorl	$1, %eax
	testb	%al, %al
	jne	.L65
	jmp	.L64
.L67:
	nop
.L64:
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	main, .-main
	.ident	"GCC: (GNU) 15.1.1 20250425"
	.section	.note.GNU-stack,"",@progbits
