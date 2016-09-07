global eval 

%include "/decls/config.s"
%include "/decls/regs.s"
%include "/utils.s"
%include "/macro/expand.s"
%include "/macro/op_def.s"
%include "/macro/next_op.s"
%include "/op_impl.s"
%include "/eval_fast.s"

segment .bss

$e_memory:
  %assign .i 0
  %rep E_COUNT
    align 16
    @@op_exec_prepared_e%+.i:
    $e%+.i: 
      resb E_SIZE
    %assign .i (.i + 1)
  %endrep

$code_root: resq 1

segment .rodata

align 8
$op_sizes:
  %include "/generated/op_sizes.s"

align 8
$op_labels: 
  %include "/generated/op_labels.s"

segment .text

;; eval is safe, public wrapper around eval_fast
;; @Args:
;;  rdi - code to execute
eval: ;{fn}
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
;{endfn}