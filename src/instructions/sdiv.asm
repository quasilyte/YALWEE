%macro @sdiv_r?_const? 2
  @#assert_nz %2

  ;; #TODO: this can be specialized based on %2 value (which is constant)
  mov rbp, %2
  mov rax, R%1
  cdq
  idiv rbp
  mov R%1, rax
%endmacro

%macro @sdiv_r?_r? 2
  mov rax, R%1
  cdq
  idiv R%2
  mov R%1, rax
%endmacro

%macro @sdiv_r?_int? 2
  ;; #TODO: compare with direct memory argument for div
  consume_int C, %2

  mov rax, R%1
  cdq
  idiv C64
  mov R%1, rax
%endmacro
