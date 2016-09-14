%macro @@dependent_instrs 0
  %ifdef HAS_LOOP
    loop_body:
      mov IP, [rsp]
      next_op
  %endif

  %ifdef HAS_FOR
    for_noop:
      consume_uint C, 32
      add IP, C64
      next_op
  %endif
%endmacro