%macro @for_nz_ops 0
  @op_break_for  
  @each_r @op_for_nz_start_by_r?
  @op_end_for_nz
%endmacro

;; shared noop body of "for" loops 
for_noop: 
  inc IP         ;; skip step
  consume_imm32 rax
  add IP, rax    ;; skip loop body
  @next_op

;; shared iteration execution 
loop_body:
  mov rdi, [rsp]
  @next_op

%macro @op_for_nz_start_by_r? 1
  @@op_for_nz_start_by_r%1:
    cmp R%1, 0
    je for_noop

    push CX  ;; preserve counter
    push STEP ;; preserve step

    movsx STEP, byte [rdi] ;; read step
    add IP, 5 ;; step & skip .noop_loop offset
    
    push rdi ;; store loop_head

    mov CX, R%1
    jmp for_nz_check
%endmacro

%macro @op_break_for 0
  @@op_break_for:
    mov IP, [rsp]
    mov eax, dword [IP-4]
    add IP, rax

    add rsp, 8 
    pop STEP 
    pop CX 
    @next_op
%endmacro

%macro @op_end_for_nz 0
  @@op_end_for_nz:
    add CX, STEP 
    for_nz_check:
      cmp CX, 0
      jne loop_body

    add rsp, 8 
    pop STEP 
    pop CX 
    @next_op
%endmacro
