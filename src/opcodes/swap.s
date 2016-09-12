%macro @swap_r?_r? 2
  @#assert_symbolic_diff %1, %2
  xchg %1, %2
%endmacro