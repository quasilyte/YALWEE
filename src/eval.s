global eval 

%include "/reg_decls.s"
%include "/op_macros.s"
%include "/op_impl.s"
%include "/eval_fast.s"

segment .text

$op_table: 
  %include "/op_labels.s"

;; eval is safe, public wrapper around eval_fast
;; @Args:
;;  rdi - code to execute
eval: ;{fn}
  ;; rax, rcx, rdx      - "caller save" 
  ;; rbp, rbx, rsi, rdi - "callee save"
  push rbx 
  push rsi 

  ;; reset counters
  xor rcx, rcx
  xor rsi, rsi

  call eval_fast

  pop rsi 
  pop rbx
  ret
;{endfn}