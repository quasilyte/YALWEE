;; internal aliases
%define A64 rax
%define A32 eax
%define A16 ax 
%define A8  al
%define B64 rdx
%define B32 edx
%define B16 dx 
%define B8  dl
%define C64 rbx
%define C32 ebx
%define C16 bx 
%define C8  bl

;; external aliases
%define ACC R0
%define FACC FR0
%define CX rsi
%define STEP rbp
%define IP rdi

;; registers
%define R0 r8
%define R1 r9
%define R2 r10
%define R3 r11
%define R4 r12
%define R5 r13
%define R6 r14
%define R7 r15
%define R8 CX

;; float registers 
%define FR0 xmm0
%define FR1 xmm1
%define FR2 xmm2
%define FR3 xmm3
%define FR4 xmm4
%define FR5 xmm5
%define FR6 xmm6
%define FR7 xmm7

;; #FIXME: xmm7+ are unused
