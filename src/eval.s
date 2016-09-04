%include "/ee_reg_decls.s"
%include "/op_macros.s"
%include "/op_impl.s"

global eval

segment .bss

code_root: resq 1
loop_head: resd 1

segment .text

%macro @push_regs 0
  push rbp
  push rbx
  push rsi 
  push rdi
%endmacro

%macro @pop_regs 0
  pop rdi
  pop rsi 
  pop rbx
  pop rbp
%endmacro

$op_table:
  dq op_exit
  @acc_labels op_acc_add_r
  @acc_labels op_acc_load_r
  @acc_labels op_acc_save_r
  @r_labels op_reset_r
  @r_labels op_inc_r
  @r_labels op_dec_r
  @r_labels op_move_8_to_r
  ;; @r_labels op_move_16_to_r
  ;; @r_labels op_move_32_to_r
  ;; @r_labels op_move_64_to_r
  @r_labels op_move_counter_to_r
  ;; @r_exc_labels op_move_r0_to_r, 0
  ;; @r_exc_labels op_move_r1_to_r, 1
  ;; @r_exc_labels op_move_r2_to_r, 2
  dq @@op_repeat
  @r_labels op_add_8_to_r
  dq @@next_op

eval_fast: ;{
  @next_op

  op_exit:
    ret
  ;; acc ops 
  @acc_ops acc_add_r
  @acc_ops acc_load_r
  @acc_ops acc_save_r
  ;; r ops
  @r_ops reset_r
  @r_ops inc_r
  @r_ops dec_r
  @r_ops move_8_to_r
  ;; @r_ops move_16_to_r
  ;; @r_ops move_32_to_r
  ;; @r_ops move_64_to_r
  @r_ops move_counter_to_r
  ;; @r_exc_ops move_r0_to_r, 0
  ;; @r_exc_ops move_r1_to_r, 1
  ;; @r_exc_ops move_r2_to_r, 2
  @@op_repeat:
    push rcx ;; reserve counter (to support loops)
    mov ecx, dword [rdi] ;; set counter to upper bound
    add rdi, 4 ;; skip counter bytes
    cmp ecx, 0 
    je noop_loop ;; counter is 0, noop
  
    add rdi, 1 ;; skip noop_loop offset
    push qword [loop_head]
    mov [loop_head], rdi
    jmp loop_check
    loop_body: 
      mov rdi, qword [loop_head]
      @next_op

    noop_loop:
      pop rcx
      movzx rax, byte [rdi]
      add rdi, rax
      @next_op
  @@next_op:
    dec ecx
    loop_check:
      cmp ecx, 0 
      jne loop_body
    pop qword [loop_head]
    pop rcx        
    @next_op
  @r_ops add_8_to_r
  

  
;}

eval: ;{
  @push_regs
  mov [code_root], rdi

  xor rcx, rcx ;; reset counter
  
  call eval_fast

  @pop_regs
  ret
;}