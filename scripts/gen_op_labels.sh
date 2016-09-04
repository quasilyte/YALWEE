#!/bin/bash

op_enum_path='tmp/op_enum.txt'
s_labels='src/op_labels.s'
c_mnemonics='src/c_api/mnemonics.h'

ruby ./scripts/gen_op_enum.rb > $op_enum_path

echo "generating $s_labels"
awk '
  BEGIN { 
    print ";; this file was generated, do not edit by hand"
  } 
  { print "dq @@op_"$0 " ;; " count++ }
' "$op_enum_path" > "$s_labels"

# FIXME: maybe later argument mathing can be automated
echo "generating $c_mnemonics"
awk '
  function opcode(count) {
    mask = 0x00000000FF
    low = and(count, mask)
    high = rshift(count, 8)
    return low "," high
  }
  function print_opcode(label,params) {
    if (params == "") {
      printf("#define %s %s\n", toupper(label), opcode(count++))
    } else {
      printf("#define %s(%s) %s,%s\n", toupper(label), params, opcode(count++), params)
    }
  }
  BEGIN {
    imm8 = "I1"
    imm32 = "I1,I2,I3,I4"
    imm64 = imm32 ",I5,I6,I7,I8"
    print "/* this file was generated, do not edit by hand */"
  }
  /^for_nz$/ {print_opcode($0, "S1,O1,O2,O3,O4"); next}
  /^jump_*/ {print_opcode($0, "O1,O2,O3,O4"); next}
  /.*imm8.*/ {print_opcode($0, imm8); next}
  /.*imm32.*/ {print_opcode($0, imm32); next}
  /.*imm64.*/ {print_opcode($0, imm64); next}
  {print_opcode($0, "")}
' "$op_enum_path" > "$c_mnemonics"
          
echo 'done'
rm "$op_enum_path"
