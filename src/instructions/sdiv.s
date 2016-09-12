%macro @sdiv_r?_const? 2
  @#assert_nz %2

  ;; #TODO: this can be specialized based on %2 value (which is constant)
  mov rbp, %2
  mov rax, %1
  cdq
  idiv rbp
  mov %1, rax
%endmacro

%macro @sdiv_r?_r? 2
  mov rax, %1
  cdq
  idiv %2
  mov %1, rax
%endmacro

%macro @sdiv_r?_int? 2
  ;; #TODO: compare with direct memory argument for div
  mov rax, %1
  cdq
  idiv %2
  mov %1, rax
%endmacro
