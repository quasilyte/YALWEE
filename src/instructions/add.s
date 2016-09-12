%macro @add_r?_const? 2
  @#assert_nz %2
  lea %1, [%1 + %2]
%endmacro

%define @add_r?_r?(a, b)     add a, b
%define @add_r?_int?(a, b)   add a, b
%define @add_r?_uint?(a, b)  add a, b
