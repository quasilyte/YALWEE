%macro @exec_prepared_ops 0
  @expand_e? @op_exec_prepared_e?
%endmacro

%macro @op_exec_prepared_e? 1
  @@op_exec_prepared_e%1:
    jmp $e%1
%endmacro



