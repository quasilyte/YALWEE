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
  @label add_r0_r0
@label add_r0_r1
@label add_r0_r2
@label add_r0_r3
@label add_r0_r4
@label add_r0_r5
@label add_r0_r6
@label add_r0_r7
@label add_r8_r0
@label add_r8_r1
@label add_r8_r2
@label add_r8_r3
@label add_r8_r4
@label add_r8_r5
@label add_r8_r6
@label add_r8_r7
@label add_r0_const1
@label add_r1_const1
@label add_r2_const1
@label add_r3_const1
@label add_r4_const1
@label add_r5_const1
@label add_r6_const1
@label add_r7_const1
@label add_r8_const1
@label add_r0_const4
@label add_r0_const8
@label add_r8_const4
@label add_r8_const8
@label add_r0_imm8
@label add_r0_imm32
@label add_r0_imm64
@label add_r1_imm8
@label add_r1_imm32
@label add_r1_imm64
@label add_r2_imm8
@label add_r2_imm32
@label add_r2_imm64
@label add_r3_imm8
@label add_r3_imm32
@label add_r3_imm64
@label add_r4_imm8
@label add_r4_imm32
@label add_r4_imm64
@label add_r5_imm8
@label add_r5_imm32
@label add_r5_imm64
@label add_r6_imm8
@label add_r6_imm32
@label add_r6_imm64
@label add_r7_imm8
@label add_r7_imm32
@label add_r7_imm64
@label add_r8_imm8
@label add_r8_imm32
@label add_r8_imm64
@label sub_r0_r0
@label sub_r0_r1
@label sub_r0_r2
@label sub_r0_r3
@label sub_r0_r4
@label sub_r0_r5
@label sub_r0_r6
@label sub_r0_r7
@label sub_r8_r0
@label sub_r8_r1
@label sub_r8_r2
@label sub_r8_r3
@label sub_r8_r4
@label sub_r8_r5
@label sub_r8_r6
@label sub_r8_r7
@label sub_r0_const1
@label sub_r1_const1
@label sub_r2_const1
@label sub_r3_const1
@label sub_r4_const1
@label sub_r5_const1
@label sub_r6_const1
@label sub_r7_const1
@label sub_r8_const1
@label sub_r0_const4
@label sub_r0_const8
@label sub_r8_const4
@label sub_r8_const8
@label sub_r0_imm8
@label sub_r0_imm32
@label sub_r0_imm64
@label sub_r1_imm8
@label sub_r1_imm32
@label sub_r1_imm64
@label sub_r2_imm8
@label sub_r2_imm32
@label sub_r2_imm64
@label sub_r3_imm8
@label sub_r3_imm32
@label sub_r3_imm64
@label sub_r4_imm8
@label sub_r4_imm32
@label sub_r4_imm64
@label sub_r5_imm8
@label sub_r5_imm32
@label sub_r5_imm64
@label sub_r6_imm8
@label sub_r6_imm32
@label sub_r6_imm64
@label sub_r7_imm8
@label sub_r7_imm32
@label sub_r7_imm64
@label sub_r8_imm8
@label sub_r8_imm32
@label sub_r8_imm64
@label mul_r0_r0
@label mul_r0_r1
@label mul_r0_r2
@label mul_r0_r3
@label mul_r0_r4
@label mul_r0_r5
@label mul_r0_r6
@label mul_r0_r7
@label mul_r0_imm8
@label mul_r0_imm32
@label mul_r0_imm64
@label mul_r1_imm8
@label mul_r1_imm32
@label mul_r1_imm64
@label mul_r2_imm8
@label mul_r2_imm32
@label mul_r2_imm64
@label mul_r3_imm8
@label mul_r3_imm32
@label mul_r3_imm64
@label mul_r4_imm8
@label mul_r4_imm32
@label mul_r4_imm64
@label mul_r5_imm8
@label mul_r5_imm32
@label mul_r5_imm64
@label mul_r6_imm8
@label mul_r6_imm32
@label mul_r6_imm64
@label mul_r7_imm8
@label mul_r7_imm32
@label mul_r7_imm64
@label div_r0_r0
@label div_r0_r1
@label div_r0_r2
@label div_r0_r3
@label div_r0_r4
@label div_r0_r5
@label div_r0_r6
@label div_r0_r7
@label div_r0_imm8
@label div_r0_imm32
@label div_r0_imm64
@label div_r1_imm8
@label div_r1_imm32
@label div_r1_imm64
@label div_r2_imm8
@label div_r2_imm32
@label div_r2_imm64
@label div_r3_imm8
@label div_r3_imm32
@label div_r3_imm64
@label div_r4_imm8
@label div_r4_imm32
@label div_r4_imm64
@label div_r5_imm8
@label div_r5_imm32
@label div_r5_imm64
@label div_r6_imm8
@label div_r6_imm32
@label div_r6_imm64
@label div_r7_imm8
@label div_r7_imm32
@label div_r7_imm64
@label bitor_r0_r0
@label bitor_r0_r1
@label bitor_r0_r2
@label bitor_r0_r3
@label bitor_r0_r4
@label bitor_r0_r5
@label bitor_r0_r6
@label bitor_r0_r7
@label bitor_r0_imm8
@label bitor_r0_imm32
@label bitor_r0_imm64
@label bitor_r1_imm8
@label bitor_r1_imm32
@label bitor_r1_imm64
@label bitor_r2_imm8
@label bitor_r2_imm32
@label bitor_r2_imm64
@label bitor_r3_imm8
@label bitor_r3_imm32
@label bitor_r3_imm64
@label bitor_r4_imm8
@label bitor_r4_imm32
@label bitor_r4_imm64
@label bitor_r5_imm8
@label bitor_r5_imm32
@label bitor_r5_imm64
@label bitor_r6_imm8
@label bitor_r6_imm32
@label bitor_r6_imm64
@label bitor_r7_imm8
@label bitor_r7_imm32
@label bitor_r7_imm64
@label bitand_r0_r0
@label bitand_r0_r1
@label bitand_r0_r2
@label bitand_r0_r3
@label bitand_r0_r4
@label bitand_r0_r5
@label bitand_r0_r6
@label bitand_r0_r7
@label bitand_r0_imm8
@label bitand_r0_imm32
@label bitand_r0_imm64
@label bitand_r1_imm8
@label bitand_r1_imm32
@label bitand_r1_imm64
@label bitand_r2_imm8
@label bitand_r2_imm32
@label bitand_r2_imm64
@label bitand_r3_imm8
@label bitand_r3_imm32
@label bitand_r3_imm64
@label bitand_r4_imm8
@label bitand_r4_imm32
@label bitand_r4_imm64
@label bitand_r5_imm8
@label bitand_r5_imm32
@label bitand_r5_imm64
@label bitand_r6_imm8
@label bitand_r6_imm32
@label bitand_r6_imm64
@label bitand_r7_imm8
@label bitand_r7_imm32
@label bitand_r7_imm64
@label abs_r0
@label abs_r1
@label abs_r2
@label abs_r3
@label abs_r4
@label abs_r5
@label abs_r6
@label abs_r7
@label neg_r0
@label neg_r1
@label neg_r2
@label neg_r3
@label neg_r4
@label neg_r5
@label neg_r6
@label neg_r7
@label set_r0_const0
@label set_r1_const0
@label set_r2_const0
@label set_r3_const0
@label set_r4_const0
@label set_r5_const0
@label set_r6_const0
@label set_r7_const0
@label set_r8_const0
@label set_r0_imm8
@label set_r0_imm32
@label set_r0_imm64
@label set_r1_imm8
@label set_r1_imm32
@label set_r1_imm64
@label set_r2_imm8
@label set_r2_imm32
@label set_r2_imm64
@label set_r3_imm8
@label set_r3_imm32
@label set_r3_imm64
@label set_r4_imm8
@label set_r4_imm32
@label set_r4_imm64
@label set_r5_imm8
@label set_r5_imm32
@label set_r5_imm64
@label set_r6_imm8
@label set_r6_imm32
@label set_r6_imm64
@label set_r7_imm8
@label set_r7_imm32
@label set_r7_imm64
@label set_r8_imm8
@label set_r8_imm32
@label set_r8_imm64
@label set_r0_r1
@label set_r0_r2
@label set_r0_r3
@label set_r0_r4
@label set_r0_r5
@label set_r0_r6
@label set_r0_r7
@label set_r1_r0
@label set_r1_r2
@label set_r1_r3
@label set_r1_r4
@label set_r1_r5
@label set_r1_r6
@label set_r1_r7
@label set_r2_r0
@label set_r2_r1
@label set_r2_r3
@label set_r2_r4
@label set_r2_r5
@label set_r2_r6
@label set_r2_r7
@label set_r3_r0
@label set_r3_r1
@label set_r3_r2
@label set_r3_r4
@label set_r3_r5
@label set_r3_r6
@label set_r3_r7
@label set_r4_r0
@label set_r4_r1
@label set_r4_r2
@label set_r4_r3
@label set_r4_r5
@label set_r4_r6
@label set_r4_r7
@label set_r5_r0
@label set_r5_r1
@label set_r5_r2
@label set_r5_r3
@label set_r5_r4
@label set_r5_r6
@label set_r5_r7
@label set_r6_r0
@label set_r6_r1
@label set_r6_r2
@label set_r6_r3
@label set_r6_r4
@label set_r6_r5
@label set_r6_r7
@label set_r7_r0
@label set_r7_r1
@label set_r7_r2
@label set_r7_r3
@label set_r7_r4
@label set_r7_r5
@label set_r7_r6
@label set_r8_r0
@label set_r8_r1
@label set_r8_r2
@label set_r8_r3
@label set_r8_r4
@label set_r8_r5
@label set_r8_r6
@label set_r8_r7
@label swap_r0_r1
@label swap_r0_r2
@label swap_r0_r3
@label swap_r0_r4
@label swap_r0_r5
@label swap_r0_r6
@label swap_r0_r7
@label test_eq_r0_r1
@label test_eq_r0_r2
@label test_eq_r0_r3
@label test_eq_r0_r4
@label test_eq_r0_r5
@label test_eq_r0_r6
@label test_eq_r0_r7
@label test_eq_r0_const0
@label test_eq_r1_const0
@label test_eq_r2_const0
@label test_eq_r3_const0
@label test_eq_r4_const0
@label test_eq_r5_const0
@label test_eq_r6_const0
@label test_eq_r7_const0
@label test_neq_r0_r1
@label test_neq_r0_r2
@label test_neq_r0_r3
@label test_neq_r0_r4
@label test_neq_r0_r5
@label test_neq_r0_r6
@label test_neq_r0_r7
@label test_neq_r0_const0
@label test_neq_r1_const0
@label test_neq_r2_const0
@label test_neq_r3_const0
@label test_neq_r4_const0
@label test_neq_r5_const0
@label test_neq_r6_const0
@label test_neq_r7_const0
@label test_lt_r0_r1
@label test_lt_r0_r2
@label test_lt_r0_r3
@label test_lt_r0_r4
@label test_lt_r0_r5
@label test_lt_r0_r6
@label test_lt_r0_r7
@label test_lte_r0_r1
@label test_lte_r0_r2
@label test_lte_r0_r3
@label test_lte_r0_r4
@label test_lte_r0_r5
@label test_lte_r0_r6
@label test_lte_r0_r7
@label test_gt_r0_r1
@label test_gt_r0_r2
@label test_gt_r0_r3
@label test_gt_r0_r4
@label test_gt_r0_r5
@label test_gt_r0_r6
@label test_gt_r0_r7
@label test_gte_r0_r1
@label test_gte_r0_r2
@label test_gte_r0_r3
@label test_gte_r0_r4
@label test_gte_r0_r5
@label test_gte_r0_r6
@label test_gte_r0_r7
@label jump_rel_imm32
@label jump_rel_if_imm32
@label jump_abs_imm32
@label jump_abs_if_imm32

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
  %include '/opcodes/add.s'
@add_r?_r? 0, 0
@add_r?_r? 0, 1
@add_r?_r? 0, 2
@add_r?_r? 0, 3
@add_r?_r? 0, 4
@add_r?_r? 0, 5
@add_r?_r? 0, 6
@add_r?_r? 0, 7
@add_r?_r? 8, 0
@add_r?_r? 8, 1
@add_r?_r? 8, 2
@add_r?_r? 8, 3
@add_r?_r? 8, 4
@add_r?_r? 8, 5
@add_r?_r? 8, 6
@add_r?_r? 8, 7
@add_r?_const? 0, 1
@add_r?_const? 1, 1
@add_r?_const? 2, 1
@add_r?_const? 3, 1
@add_r?_const? 4, 1
@add_r?_const? 5, 1
@add_r?_const? 6, 1
@add_r?_const? 7, 1
@add_r?_const? 8, 1
@add_r?_const? 0, 4
@add_r?_const? 0, 8
@add_r?_const? 8, 4
@add_r?_const? 8, 8
@add_r?_imm? 0, 8
@add_r?_imm? 0, 32
@add_r?_imm? 0, 64
@add_r?_imm? 1, 8
@add_r?_imm? 1, 32
@add_r?_imm? 1, 64
@add_r?_imm? 2, 8
@add_r?_imm? 2, 32
@add_r?_imm? 2, 64
@add_r?_imm? 3, 8
@add_r?_imm? 3, 32
@add_r?_imm? 3, 64
@add_r?_imm? 4, 8
@add_r?_imm? 4, 32
@add_r?_imm? 4, 64
@add_r?_imm? 5, 8
@add_r?_imm? 5, 32
@add_r?_imm? 5, 64
@add_r?_imm? 6, 8
@add_r?_imm? 6, 32
@add_r?_imm? 6, 64
@add_r?_imm? 7, 8
@add_r?_imm? 7, 32
@add_r?_imm? 7, 64
@add_r?_imm? 8, 8
@add_r?_imm? 8, 32
@add_r?_imm? 8, 64
%include '/opcodes/sub.s'
@sub_r?_r? 0, 0
@sub_r?_r? 0, 1
@sub_r?_r? 0, 2
@sub_r?_r? 0, 3
@sub_r?_r? 0, 4
@sub_r?_r? 0, 5
@sub_r?_r? 0, 6
@sub_r?_r? 0, 7
@sub_r?_r? 8, 0
@sub_r?_r? 8, 1
@sub_r?_r? 8, 2
@sub_r?_r? 8, 3
@sub_r?_r? 8, 4
@sub_r?_r? 8, 5
@sub_r?_r? 8, 6
@sub_r?_r? 8, 7
@sub_r?_const? 0, 1
@sub_r?_const? 1, 1
@sub_r?_const? 2, 1
@sub_r?_const? 3, 1
@sub_r?_const? 4, 1
@sub_r?_const? 5, 1
@sub_r?_const? 6, 1
@sub_r?_const? 7, 1
@sub_r?_const? 8, 1
@sub_r?_const? 0, 4
@sub_r?_const? 0, 8
@sub_r?_const? 8, 4
@sub_r?_const? 8, 8
@sub_r?_imm? 0, 8
@sub_r?_imm? 0, 32
@sub_r?_imm? 0, 64
@sub_r?_imm? 1, 8
@sub_r?_imm? 1, 32
@sub_r?_imm? 1, 64
@sub_r?_imm? 2, 8
@sub_r?_imm? 2, 32
@sub_r?_imm? 2, 64
@sub_r?_imm? 3, 8
@sub_r?_imm? 3, 32
@sub_r?_imm? 3, 64
@sub_r?_imm? 4, 8
@sub_r?_imm? 4, 32
@sub_r?_imm? 4, 64
@sub_r?_imm? 5, 8
@sub_r?_imm? 5, 32
@sub_r?_imm? 5, 64
@sub_r?_imm? 6, 8
@sub_r?_imm? 6, 32
@sub_r?_imm? 6, 64
@sub_r?_imm? 7, 8
@sub_r?_imm? 7, 32
@sub_r?_imm? 7, 64
@sub_r?_imm? 8, 8
@sub_r?_imm? 8, 32
@sub_r?_imm? 8, 64
%include '/opcodes/mul.s'
@mul_r?_r? 0, 0
@mul_r?_r? 0, 1
@mul_r?_r? 0, 2
@mul_r?_r? 0, 3
@mul_r?_r? 0, 4
@mul_r?_r? 0, 5
@mul_r?_r? 0, 6
@mul_r?_r? 0, 7
@mul_r?_imm? 0, 8
@mul_r?_imm? 0, 32
@mul_r?_imm? 0, 64
@mul_r?_imm? 1, 8
@mul_r?_imm? 1, 32
@mul_r?_imm? 1, 64
@mul_r?_imm? 2, 8
@mul_r?_imm? 2, 32
@mul_r?_imm? 2, 64
@mul_r?_imm? 3, 8
@mul_r?_imm? 3, 32
@mul_r?_imm? 3, 64
@mul_r?_imm? 4, 8
@mul_r?_imm? 4, 32
@mul_r?_imm? 4, 64
@mul_r?_imm? 5, 8
@mul_r?_imm? 5, 32
@mul_r?_imm? 5, 64
@mul_r?_imm? 6, 8
@mul_r?_imm? 6, 32
@mul_r?_imm? 6, 64
@mul_r?_imm? 7, 8
@mul_r?_imm? 7, 32
@mul_r?_imm? 7, 64
%include '/opcodes/div.s'
@div_r?_r? 0, 0
@div_r?_r? 0, 1
@div_r?_r? 0, 2
@div_r?_r? 0, 3
@div_r?_r? 0, 4
@div_r?_r? 0, 5
@div_r?_r? 0, 6
@div_r?_r? 0, 7
@div_r?_imm? 0, 8
@div_r?_imm? 0, 32
@div_r?_imm? 0, 64
@div_r?_imm? 1, 8
@div_r?_imm? 1, 32
@div_r?_imm? 1, 64
@div_r?_imm? 2, 8
@div_r?_imm? 2, 32
@div_r?_imm? 2, 64
@div_r?_imm? 3, 8
@div_r?_imm? 3, 32
@div_r?_imm? 3, 64
@div_r?_imm? 4, 8
@div_r?_imm? 4, 32
@div_r?_imm? 4, 64
@div_r?_imm? 5, 8
@div_r?_imm? 5, 32
@div_r?_imm? 5, 64
@div_r?_imm? 6, 8
@div_r?_imm? 6, 32
@div_r?_imm? 6, 64
@div_r?_imm? 7, 8
@div_r?_imm? 7, 32
@div_r?_imm? 7, 64
%include '/opcodes/bitor.s'
@bitor_r?_r? 0, 0
@bitor_r?_r? 0, 1
@bitor_r?_r? 0, 2
@bitor_r?_r? 0, 3
@bitor_r?_r? 0, 4
@bitor_r?_r? 0, 5
@bitor_r?_r? 0, 6
@bitor_r?_r? 0, 7
@bitor_r?_imm? 0, 8
@bitor_r?_imm? 0, 32
@bitor_r?_imm? 0, 64
@bitor_r?_imm? 1, 8
@bitor_r?_imm? 1, 32
@bitor_r?_imm? 1, 64
@bitor_r?_imm? 2, 8
@bitor_r?_imm? 2, 32
@bitor_r?_imm? 2, 64
@bitor_r?_imm? 3, 8
@bitor_r?_imm? 3, 32
@bitor_r?_imm? 3, 64
@bitor_r?_imm? 4, 8
@bitor_r?_imm? 4, 32
@bitor_r?_imm? 4, 64
@bitor_r?_imm? 5, 8
@bitor_r?_imm? 5, 32
@bitor_r?_imm? 5, 64
@bitor_r?_imm? 6, 8
@bitor_r?_imm? 6, 32
@bitor_r?_imm? 6, 64
@bitor_r?_imm? 7, 8
@bitor_r?_imm? 7, 32
@bitor_r?_imm? 7, 64
%include '/opcodes/bitand.s'
@bitand_r?_r? 0, 0
@bitand_r?_r? 0, 1
@bitand_r?_r? 0, 2
@bitand_r?_r? 0, 3
@bitand_r?_r? 0, 4
@bitand_r?_r? 0, 5
@bitand_r?_r? 0, 6
@bitand_r?_r? 0, 7
@bitand_r?_imm? 0, 8
@bitand_r?_imm? 0, 32
@bitand_r?_imm? 0, 64
@bitand_r?_imm? 1, 8
@bitand_r?_imm? 1, 32
@bitand_r?_imm? 1, 64
@bitand_r?_imm? 2, 8
@bitand_r?_imm? 2, 32
@bitand_r?_imm? 2, 64
@bitand_r?_imm? 3, 8
@bitand_r?_imm? 3, 32
@bitand_r?_imm? 3, 64
@bitand_r?_imm? 4, 8
@bitand_r?_imm? 4, 32
@bitand_r?_imm? 4, 64
@bitand_r?_imm? 5, 8
@bitand_r?_imm? 5, 32
@bitand_r?_imm? 5, 64
@bitand_r?_imm? 6, 8
@bitand_r?_imm? 6, 32
@bitand_r?_imm? 6, 64
@bitand_r?_imm? 7, 8
@bitand_r?_imm? 7, 32
@bitand_r?_imm? 7, 64
%include '/opcodes/abs.s'
@abs_r? 0
@abs_r? 1
@abs_r? 2
@abs_r? 3
@abs_r? 4
@abs_r? 5
@abs_r? 6
@abs_r? 7
%include '/opcodes/neg.s'
@neg_r? 0
@neg_r? 1
@neg_r? 2
@neg_r? 3
@neg_r? 4
@neg_r? 5
@neg_r? 6
@neg_r? 7
%include '/opcodes/set.s'
@set_r?_const? 0, 0
@set_r?_const? 1, 0
@set_r?_const? 2, 0
@set_r?_const? 3, 0
@set_r?_const? 4, 0
@set_r?_const? 5, 0
@set_r?_const? 6, 0
@set_r?_const? 7, 0
@set_r?_const? 8, 0
@set_r?_imm? 0, 8
@set_r?_imm? 0, 32
@set_r?_imm? 0, 64
@set_r?_imm? 1, 8
@set_r?_imm? 1, 32
@set_r?_imm? 1, 64
@set_r?_imm? 2, 8
@set_r?_imm? 2, 32
@set_r?_imm? 2, 64
@set_r?_imm? 3, 8
@set_r?_imm? 3, 32
@set_r?_imm? 3, 64
@set_r?_imm? 4, 8
@set_r?_imm? 4, 32
@set_r?_imm? 4, 64
@set_r?_imm? 5, 8
@set_r?_imm? 5, 32
@set_r?_imm? 5, 64
@set_r?_imm? 6, 8
@set_r?_imm? 6, 32
@set_r?_imm? 6, 64
@set_r?_imm? 7, 8
@set_r?_imm? 7, 32
@set_r?_imm? 7, 64
@set_r?_imm? 8, 8
@set_r?_imm? 8, 32
@set_r?_imm? 8, 64
@set_r?_r? 0, 1
@set_r?_r? 0, 2
@set_r?_r? 0, 3
@set_r?_r? 0, 4
@set_r?_r? 0, 5
@set_r?_r? 0, 6
@set_r?_r? 0, 7
@set_r?_r? 1, 0
@set_r?_r? 1, 2
@set_r?_r? 1, 3
@set_r?_r? 1, 4
@set_r?_r? 1, 5
@set_r?_r? 1, 6
@set_r?_r? 1, 7
@set_r?_r? 2, 0
@set_r?_r? 2, 1
@set_r?_r? 2, 3
@set_r?_r? 2, 4
@set_r?_r? 2, 5
@set_r?_r? 2, 6
@set_r?_r? 2, 7
@set_r?_r? 3, 0
@set_r?_r? 3, 1
@set_r?_r? 3, 2
@set_r?_r? 3, 4
@set_r?_r? 3, 5
@set_r?_r? 3, 6
@set_r?_r? 3, 7
@set_r?_r? 4, 0
@set_r?_r? 4, 1
@set_r?_r? 4, 2
@set_r?_r? 4, 3
@set_r?_r? 4, 5
@set_r?_r? 4, 6
@set_r?_r? 4, 7
@set_r?_r? 5, 0
@set_r?_r? 5, 1
@set_r?_r? 5, 2
@set_r?_r? 5, 3
@set_r?_r? 5, 4
@set_r?_r? 5, 6
@set_r?_r? 5, 7
@set_r?_r? 6, 0
@set_r?_r? 6, 1
@set_r?_r? 6, 2
@set_r?_r? 6, 3
@set_r?_r? 6, 4
@set_r?_r? 6, 5
@set_r?_r? 6, 7
@set_r?_r? 7, 0
@set_r?_r? 7, 1
@set_r?_r? 7, 2
@set_r?_r? 7, 3
@set_r?_r? 7, 4
@set_r?_r? 7, 5
@set_r?_r? 7, 6
@set_r?_r? 8, 0
@set_r?_r? 8, 1
@set_r?_r? 8, 2
@set_r?_r? 8, 3
@set_r?_r? 8, 4
@set_r?_r? 8, 5
@set_r?_r? 8, 6
@set_r?_r? 8, 7
%include '/opcodes/swap.s'
@swap_r?_r? 0, 1
@swap_r?_r? 0, 2
@swap_r?_r? 0, 3
@swap_r?_r? 0, 4
@swap_r?_r? 0, 5
@swap_r?_r? 0, 6
@swap_r?_r? 0, 7
%include '/opcodes/test_eq.s'
@test_eq_r?_r? 0, 1
@test_eq_r?_r? 0, 2
@test_eq_r?_r? 0, 3
@test_eq_r?_r? 0, 4
@test_eq_r?_r? 0, 5
@test_eq_r?_r? 0, 6
@test_eq_r?_r? 0, 7
@test_eq_r?_const? 0, 0
@test_eq_r?_const? 1, 0
@test_eq_r?_const? 2, 0
@test_eq_r?_const? 3, 0
@test_eq_r?_const? 4, 0
@test_eq_r?_const? 5, 0
@test_eq_r?_const? 6, 0
@test_eq_r?_const? 7, 0
%include '/opcodes/test_neq.s'
@test_neq_r?_r? 0, 1
@test_neq_r?_r? 0, 2
@test_neq_r?_r? 0, 3
@test_neq_r?_r? 0, 4
@test_neq_r?_r? 0, 5
@test_neq_r?_r? 0, 6
@test_neq_r?_r? 0, 7
@test_neq_r?_const? 0, 0
@test_neq_r?_const? 1, 0
@test_neq_r?_const? 2, 0
@test_neq_r?_const? 3, 0
@test_neq_r?_const? 4, 0
@test_neq_r?_const? 5, 0
@test_neq_r?_const? 6, 0
@test_neq_r?_const? 7, 0
%include '/opcodes/test_lt.s'
@test_lt_r?_r? 0, 1
@test_lt_r?_r? 0, 2
@test_lt_r?_r? 0, 3
@test_lt_r?_r? 0, 4
@test_lt_r?_r? 0, 5
@test_lt_r?_r? 0, 6
@test_lt_r?_r? 0, 7
%include '/opcodes/test_lte.s'
@test_lte_r?_r? 0, 1
@test_lte_r?_r? 0, 2
@test_lte_r?_r? 0, 3
@test_lte_r?_r? 0, 4
@test_lte_r?_r? 0, 5
@test_lte_r?_r? 0, 6
@test_lte_r?_r? 0, 7
%include '/opcodes/test_gt.s'
@test_gt_r?_r? 0, 1
@test_gt_r?_r? 0, 2
@test_gt_r?_r? 0, 3
@test_gt_r?_r? 0, 4
@test_gt_r?_r? 0, 5
@test_gt_r?_r? 0, 6
@test_gt_r?_r? 0, 7
%include '/opcodes/test_gte.s'
@test_gte_r?_r? 0, 1
@test_gte_r?_r? 0, 2
@test_gte_r?_r? 0, 3
@test_gte_r?_r? 0, 4
@test_gte_r?_r? 0, 5
@test_gte_r?_r? 0, 6
@test_gte_r?_r? 0, 7
%include '/opcodes/jump_rel.s'
@jump_rel_imm? 32
%include '/opcodes/jump_rel_if.s'
@jump_rel_if_imm? 32
%include '/opcodes/jump_abs.s'
@jump_abs_imm? 32
%include '/opcodes/jump_abs_if.s'
@jump_abs_if_imm? 32
  @@next_op: next_op
