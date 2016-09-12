%macro next_op 0
  movzx rax, word [IP]
  add IP, 2 ;; each opcode is 2 bytes wide
  jmp [$op_labels + (rax * 8)]
%endmacro