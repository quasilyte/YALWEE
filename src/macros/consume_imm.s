%macro consume_imm8 1
  move_imm8 %1
  add IP, 1
%endmacro

%macro consume_imm16 1
  move_imm16 %1
  add IP, 2
%endmacro

%macro consume_imm32 1
  move_imm32 %1
  add IP, 4
%endmacro

%macro consume_imm64 1
  move_imm64 %1
  add IP, 8
%endmacro