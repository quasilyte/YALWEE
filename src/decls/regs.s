;; registers
%define R0 r8
%define R1 r9
%define R2 r10
%define R3 r11
%define R4 r12
%define R5 r13
%define R6 r14
%define R7 r15

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

;; register aliases
%define ACC R0
%define FACC FR0
%define CX rsi
%define STEP rbx
%define IP rdi
