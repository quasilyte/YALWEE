%macro @swap_r?_r? 2
  @#assert_numeric_diff %1, %2
  xchg R%1, R%2
%endmacro