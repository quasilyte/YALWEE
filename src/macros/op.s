%macro @op 2
  @@%1:
    @@%1_begin:
      %2
    @@%1_end:
      next_op
%endmacro

%macro @op_begin 1
  %define .op_name %1
  @@%1:
    @@%1_begin:
%endmacro

%macro @op_end 0
  @@%[.op_name]_end:
    next_op
%endmacro

%macro @op_expand 4
  @op %2, {@macro_call %1, %3, %4}

  ;;%ifmacro %1
  ;;  @op %2, {%1 %3, %4}
  ;;%elifdef %1
  ;;  @op %2, {%1(%3, %4)}
  ;;%else
  ;;  %error %[%1] overloading undefined
  ;;%endif
%endmacro

%macro @op_expand 3
  %ifmacro %1
    @op %2, {%1 %3}
  %elifdef %1
    @op %2, {%1(%3)}
  %else
    %error %[%1] overloading undefined
  %endif
%endmacro

%macro @?_r?_const? 3
  @op %1_r%2_const%3, {@macro_call @%1_r?_const?, R%2, %3}
%endmacro

%macro @?_r?_r? 3
  @op %1_r%2_r%3, {@macro_call @%1_r?_r?, R%2, R%3}
%endmacro

%macro @?_r? 2
  @op %1_r%2, {@macro_call @%1_r?, R%2}
%endmacro

%macro @?_r?_int? 3
  @op_begin %1_r%2_int%3
    consume_int %3, rbp
    @macro_call @%1_r?_int?, R%2, rbp
  @op_end
%endmacro

%macro @?_r?_uint? 3
  @op_begin %1_r%2_uint%3
    consume_uint %3, rbp
    @macro_call @%1_r?_uint?, R%2, rbp
  @op_end
%endmacro
