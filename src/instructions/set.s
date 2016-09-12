%macro @set_r?_const? 2
  %assign %%const %2

  %if %%const = 0
    xor %1, %1
  %else
    mov %1, %%const
  %endif
%endmacro

%macro @set_r?_r? 2
  @#assert_symbolic_diff %1, %2
  mov %1, %2
%endmacro

%define @set_r?_int?(a, b) mov a, b
%define @set_r?_uint?(a, b) mov a, b
