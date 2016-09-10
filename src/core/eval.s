global eval 

;;;; macro definitions
%include "/core/decls/regs.s"
%include "/macros/move_imm.s"
%include "/macros/consume_imm.s"
%include "/macros/next_op.s"
%include "/macros/label.s"
%include "/macros/op.s"

;;;; optionally redefined values
;[[options]];

segment .rodata

;;;; jump table for operation decoding
$op_labels:
  dq @@exit
  ;[[op_labels]];

segment .bss

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

  mov [$code_root], rdi 
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
;; @Params:
;;  rdi -- binary code to execute
;; 
;; @Uses:
;;  rax -- tmp1
;;  rdx -- tmp2
;;  rbp -- tmp3
;;  rcx -- external logical register 
;;  rbx -- external counter step
;;  rsi -- external counter
;;  r8-r15    -- external registers
;;  xmm0-xmm7 -- external float registers
;;
eval_fast: 
  next_op ;; go to first opcode

  ;; opcode block below contains all supported actions
  @@exit: ret
  ;[[op_generators]];
  @@next_op: next_op
