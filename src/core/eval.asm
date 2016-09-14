global eval 

;;;; macro definitions
%include "/core/decls/regs.asm"
%include "/core/decls/ptr.asm"
%include "/macros/validation.asm"
%include "/macros/assertions.asm"
%include "/macros/instr.asm"
%include "/macros/macro_call.asm"
%include "/macros/move_int.asm"
%include "/macros/move_uint.asm"
%include "/macros/consume_int.asm"
%include "/macros/consume_uint.asm"
%include "/macros/next_op.asm"
%include "/macros/label.asm"
%include "/macros/dependent_instrs.asm"

;;;; includes required by spec
%include "/deps.asm"

;;;; optionally redefined values
;; #TODO: include file with user options

segment .rodata

;;;; jump table for operation decoding
$op_labels:
  dq @@exit
  %include "/instruction_labels.asm"
  dq @@next_op

segment .bss

;; IP starting position address
$code_root: resq 1

segment .text

;;;;
;; eval is safe, public wrapper around eval_fast
;; 
;; @params:
;;  rdi - code to execute
;;
eval: 
  ;; rax, rcx, rdx      - "caller save" 
  ;; rbp, rbx, rsi, rdi - "callee save"
  
  push rbx 
  push rsi 
  push rbp

  mov [$code_root], IP 
  xor CX, CX     ;; reset counter
  call eval_fast ;; interpret code

  pop rbp
  pop rsi 
  pop rbx

  ret

;;;;
;; eval_fast is a real evaluator.
;; It is unsafe to call this from C code.
;; Invalid binary code leads to undefined behavior,
;; eval_fast performs no validation.
;;
;;  rax -- tmp1
;;  rdx -- tmp2
;;  rbx -- tmp3
;;  rcx -- external logical register 
;;  rbp -- external counter step
;;  rsi -- external counter
;;  r8-r15    -- external registers
;;  xmm0-xmm7 -- external float registers
;;
;; @params:
;;  rdi -- binary code to execute
;;
eval_fast: 
  next_op ;; go to first opcode

  ;; opcode block below contains all supported actions
  @@exit: ret
  %include "/instruction_generators.asm"
  @@dependent_instrs
  @@next_op: next_op
  