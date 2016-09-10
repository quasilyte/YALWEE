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

%macro @op_r? 2
  %define .name %1
  %define .body %2

  %macro @%[.name]_r? 1
    %define .a R%1

    @op %[.name]_r%1, {%[.body]}
  %endmacro
%endmacro

%macro @op_r?_const? 2
  %define .name %1
  %define .body %2

  %macro @%[.name]_r?_const? 2
    %define .a R%1
    %define .b %2
    
    @op %[.name]_r%1_const%2, {%[.body]}
  %endmacro
%endmacro

%macro @op_r?_r? 2
  %define .name %1
  %define .body %2

  %macro @%[.name]_r?_r? 2
    %define .a R%1
    %define .b R%2
    
    @op %[.name]_r%1_r%2, {%[.body]}
  %endmacro
%endmacro

%macro @op_imm? 2
  %define .name %1
  %define .body %2

  %macro @%[.name]_imm? 1
    %define .a rbp

    @op_begin %[.name]_imm%1
      consume_imm%1 .a
      %[.body]
    @op_end
  %endmacro
%endmacro

%macro @op_r?_imm? 2
  %define .name %1
  %define .body %2

  %macro @%[.name]_r?_imm? 2
    %define .a R%1
    %define .b rbp

    @op_begin %[.name]_r%1_imm%2
      consume_imm%2 .b 
      %[.body]
    @op_end
  %endmacro
%endmacro