# $Id: test6LS-x86.asm,v 1.1 2008/10/30 19:21:22 legendre Exp $
#
# This file must NOT be assembled with nasm  - http://freshmeat.net/projects/nasm/

.file	"test6LS.S"
		
.text
.align 16

.global loadsnstores
.type loadsnstores,@function
       
.global ia32features
.type ia32features,@function

.global amd_features
.type amd_features,@function                            

                
loadsnstores: 
# IA32 System V ABI - ebp, ebx, edi, esi, esp "belong" to caller
#     rep movsd

    push %ebp                  # s1
    movl %esp,%ebp

    push %edi
    push %esi
    push %ebx

    movl $divarw, %eax
    movl %eax,%ecx
    movl %eax,%ebx
    movl %eax,%edx
    movl %eax,%ebx
    movl %eax,%esi
    movl %eax,%edi

# == addressing modes tests ==

# mod/rm decoding tests - 32 bit

# mod == 0
    movl (%eax),%eax            # a5
    movl (%ecx),%eax
    movl (%edx),%eax
    movl (%ebx),%eax
    ## sib case tested separately
    movl divarw,%eax
    movl (%esi),%eax
    movl (%edi),%eax

    movl $divarw, %eax

# mod == 1
    movl 4(%eax),%eax           # a12
    movl 8(%ecx),%eax
    movl 4(%edx),%eax
    movl 8(%ebx),%eax
    ## sib case tested separately
    movl 4(%ebp),%eax
    movl 8(%esi),%eax
    movl 4(%edi),%eax

    movl $1,%eax
    movl %eax,%ebx
    movl %eax,%ecx
    movl %eax,%edx
    movl %eax,%esi
    movl %eax,%edi

    pushl %ebp                  # temporarily destroy frame pointer; confuse debuggers - s5 a19
    movl %eax,%ebp

# mod == 2
    movl divarw-1(%eax),%eax    # a20
    movl divarw+3(%ecx),%eax
    movl divarw+7(%edx),%eax
    movl divarw+11(%ebx),%eax
    ## sib case tested separately
    movl divarw-1(%ebp),%eax
    movl divarw+3(%esi),%eax
    movl divarw+7(%edi),%eax

    movl $divarw, %eax

# sib tests

        movl %eax,%ebx
    movl %eax,%ebp

    xorl %edx,%edx
    movl $4,%ecx
    movl $12,%esi

    movl (%ebx,%esi),%eax       # l22 a28
    movl (%esp),%eax
    movl (%ebx,%ecx,2),%eax
    movl divarw(,%ecx,2), %eax
    movl 4(%ebx,%ecx),%eax
    movl divarw(%edx,%edx,8),%eax
    movl $1,%ecx
    movl 2(%ebp,%ecx,2),%eax    # l28
    movl 4(%ebx,%ecx,4),%eax
    movl $0,%ebp
    movl divarw(%ebp,%ecx,4),%eax

    popl %ebp                   # l31 a37

# other addressing modes not using modrm

    ## X, Y tested in the next section
    ## wierd instructions TBD

# == semantic classes tests ==

    ## sNONE well tested anyhow
    ## s1R is tested at prefetch
    ## s1W is tested at stmxcsr(SSE)
    incl divarw+4               # s1RW                                              - l32 s6 a38
    cmpl divarw+4,%eax          # s1R2R [one operand is register]
    movl $divarw, %edi
    movl $divarw+4, %esi
    cmpsb                       # s1R2R [both operands are memory]                  - l34 a40&41
    movl %edi,divarw+4          # s1W2R                                             - s7
    addl %eax,divarw            # s1RW2R                                            - l35 s8
    xchgl %edi,divarw+4         # s1RW2RW [one operand is register]                 - l36 s9
    imul $3, divarw+8, %eax
    xorl %eax,%eax
    movw %ds,%ax
    movl $divarw, %edx
    movl %edx,divarw            # s10
    #lds eax,[divarw+2]          ; s1W2W3R [two regs, one mem]                       - l38
    mulb divarw                 # hope it gens mul edx:eax, [divarw] - s1W2RW3R     - l39
    ## s1W2R3RW - push & pop we've got plenty
    shld $3, %eax, divarw+4
    movl $4,%eax
    movl $5,%edx
    idivl divarw                # s1RW2RW3R                                         - l41 a48

# == MMX/SSE/SSE2 instructions test ==

    call ia32features
    testl $1<<23, %eax
    jz   loadsnstores.bail      # assuming it cannot do sse/sse2

# MMX test
    movd divarw,%mm0            # l42 a50
    pmaddwd divarw+8,%mm0
    psraw $2,%mm0               # just decoder test for MMX groups
    movntq %mm0,divarw          # s12, non-temporal
    emms

# TODO:    test fxsr?

    call ia32features
    testl $1<<25, %eax
    jz   loadsnstores.bail      # assuming it cannot do sse2

# SSE test    
    movaps dfvars, %xmm0
    cmpeqss dfvars, %xmm0
    prefetcht0 divarw           # not sure about this, but seem safe only if CPU knows SSE

    call ia32features
    testl $1<<26, %eax
    jz   loadsnstores.bail

# SSE2 test
    movapd dfvard, %xmm1
    cmpeqsd dfvard, %xmm0
    psrldq $2, %xmm0

loadsnstores.bail: 

# == 3DNow! instructions test ==

    call amd_features
    testl $0x80000000,%eax
    jz   loadsnstores.bail2

# since registers are shared with mmx, there are no special loads
    movq dfvars,%mm0            # l48 a56
    pfmin dfvars+8,%mm0         # memory is only read by 3DNow! instructions        - l49
    prefetch   divarw
    femms                       # is this needed?

# Athlon extensions to 3DNow! not tested (feature bit 30) - most of them are
# a subset of SSE which is fully implemented on the Athlon XP/MP anyway...

loadsnstores.bail2: 

# == REP prefixed stuff test

    cld
    movl $12/4, %ecx
    movl $10,%eax
    movl $divarw, %edi
    rep
    stosl                       # s13 a58 a56onP4 a54onP3

    std
    movl $16/4, %ecx
    movl $divarw+16-4, %edi
    stosl
#    rep stosd                   ; s14

    cld
    movl $16/4, %ecx
    movl $dfvars, %esi
    movl $divarw, %edi
#    movsd
    rep
    movsl                       # l50 s15 

    movl $0,%eax                # only al matters...
    movl $256,%ecx
    movl $dlarge, %edi
    repne scasb

    movl $256,%ecx
    movl $dlarge+25, %edi
    movl $dlarge+44, %esi
    repe cmpsb

# == addressing using 16-bit registers ==

    ## TBD

# == x87 FP instructions test ==

    fld dfvars                 # l51 a60
    fldl dfvard
    fldt dfvart
    fild divarw
    fildl divarw+4
    fildll divarw+8

    fstl dfvars                 # s16 a66
    fstpl dfvard
    fstpt dfvart
    fist divarw+2
    fistl divarw+4
    fistpll divarw+8

    fnstcw divarw               # s21
    fldcw divarw                # l57
    fnstenv dlarge
    fldenv dlarge               # l58 a75

# == conditional moves ==

    movl $3,%eax
    movl $2,%edx
    movl $0,%ecx
    cmpl %edx,%eax
    cmova divarw, %ecx
    cmove divarw+4, %ebx
    movl divarw+8,%ebx          # sync point   - a78

    popl %ebx                   # l59 a76
    popl %esi
    popl %edi

    leave                       # now counts as load! 
    ret                         # now counts as load! 
loadsnstores.end: 


ia32features: 
    movl $1,%eax
    pushl %ebx                  # cpuid changes ebx as well, but ebx "belongs" to the caller
    cpuid
    movl %edx,%eax
    popl %ebx
    ret
ia32features.end: 


amd_features: 
    movl $0x80000000,%eax
    pushl %ebx                  # cpuid changes ebx as well, but ebx "belongs" to the caller
    cpuid
    cmpl $0x80000000,%eax
    jbe amd_features.noext
    movl $0x80000001,%eax
    cpuid
    movl %edx,%eax
    jmp amd_features.done
amd_features.noext: 
    movl $0,%eax
amd_features.done: 
    popl %ebx
    ret
amd_features.end: 

