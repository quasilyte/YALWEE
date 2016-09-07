;; eval_fast is a real evaluator.
;; It is unsafe to call this from C code.
;; Invalid binary code leads to undefined behavior,
;; eval_fast performs no validation.
;; @Args:
;;  rdi -- binary code to execute
;; @Uses:
;;  rax -- tmp1
;;  rdx -- tmp2
;;  rbp -- tmp3
;;  rcx -- external logical register 
;;  rbx -- external counter step
;;  rsi -- external counter
;;  r8-r15    -- external registers
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
  @div_ops  
  @bitor_ops  
  @bitand_ops  
  @for_nz_ops
  @abs_ops
  @neg_ops
  @fill_ops
  @prepare_ops
  @swap_ops
  @logical_ops
  @jump_ops
  
  @@stop:
    @next_op

  @experimental_ops

;{endfn}
