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

  ;; order of definitions here really matters,
  ;; this section is VERY sensitive to alignment.
  ;; do not move lines around unless you know what
  ;; you are doing
  @@op_exit:
    @@op_exit_begin: 
      ret
    @@op_exit_end:
  @inc_ops
  @dec_ops  
  @mul_ops  
  @for_nz_ops
  @abs_ops
  @neg_ops
  @fill_ops
  @prepare_ops
  @exec_prepared_ops
  
  @@stop:
    @next_op

  @experimental_ops

;{endfn}
