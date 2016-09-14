%define instr_label(instr) @@ %+ instr
%define instr_begin(instr) @@ %+ instr %+ _begin
%define instr_end(instr) @@ %+ instr %+ _end

%macro @instr 2
  instr_label(%1):
  instr_begin(%1):
    %2
  instr_end(%1):
    next_op
%endmacro

;; Generate specific instruction implementation
;; using meta parameters 
%macro @@instr 1-*
  %if (%0 % 2) = 0
    %fatal even param count is an error (count = %[%0])
  %endif

  %assign %%arity ((%0 - 1) / 2)

  ;; Validate params
  %assign %%n 0
  %rotate 1
  %rep %%arity
    %define %%type  %[%1]
    %define %%value %[%2]

    %[@#validate_%[%%type]]_arg %%value 

    %assign %%n (%%n + 1)
    %rotate 2
  %endrep
  ;; After this loop params are rotated into original order

  %if   %%arity = 0
    %define %%name   %1
    %define %%label  %1
  %elif %%arity = 1
    %define %%name   %1_%2?
    %define %%params %3
    %define %%label  %1_%2%3
  %elif %%arity = 2
    %define %%name   %1_%2?_%4?
    %define %%params %3, %5
    %define %%label  %1_%2%3_%4%5
  %elif %%arity = 3
    %define %%name   %1_%2?_%4?_%6?
    %define %%params %3, %5, %7
    %define %%label  %1_%2%3_%4%5_%6%7
  %else
    %fatal strange instr param count (arity = %[%%arity])
  %endif

  ;; If instr_* macro is defined, it should be called directly,
  ;; without "@instr" proxy call 
  %ifmacro @instr_%[%%name]
    %if %%arity = 0
      @instr_%[%%name]
    %else
      @instr_%[%%name] %%params    
    %endif
  %else 
    %if %%arity = 0
      @instr %%label, {@macro_call @%[%%name]}            
    %else 
      @instr %%label, {@macro_call @%[%%name], %%params}      
    %endif
  %endif  
%endmacro
