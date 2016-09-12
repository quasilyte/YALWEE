%macro @set_r?_const? 2
  %assign %%const %2

  %if %%const = 0
    xor R%1, R%1
  %else
    mov R%1, %%const
  %endif
%endmacro

%macro @set_r?_r? 2
  @#assert_numeric_diff %1, %2
  mov R%1, R%2
%endmacro

%macro @set_r?_int? 2
  consume_int C, %2
  mov R%1, C64
%endmacro

%macro @set_r?_uint? 2
  consume_uint C, %2
  mov R%1, C64
%endmacro
