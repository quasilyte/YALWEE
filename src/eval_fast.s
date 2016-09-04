;; eval_fast is a real evaluator.
;; It is unsafe to call this from C code.
;; Invalid binary code leads to undefined behavior,
;; eval_fast performs no validation.
;; @Args:
;;  rdi -- binary code to execute
;; @Uses:
;;  rax -- tmp1
;;  rdx -- tmp2
;;  rbx -- external counter step
;;  rsi -- external counter
;;  rcx -- internal counter
;;  r8-r15 -- external registers
;;  xmm0-xmm7 -- external float registers
eval_fast: ;{fn}
  @next_op

  @@op_exit: ret
  @inc_ops
  @dec_ops
  @for_nz_ops
  @abs_ops
  @neg_ops

;{endfn}
