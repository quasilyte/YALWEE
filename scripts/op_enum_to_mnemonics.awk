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
  print "/* this file was generated, do not edit by hand */"
}

# FIXME: maybe later argument mathing can be automated

/^for_*/ {print_opcode($0, "S1,O1,O2,O3,O4"); next}
/^jump_*/ {print_opcode($0, "O1,O2,O3,O4"); next}
/.*imm8.*/ {print_opcode($0, "I1"); next}
/.*imm32.*/ {print_opcode($0, "I1,I2,I3,I4"); next}
/.*imm64.*/ {print_opcode($0, "I1,I2,I3,I4,I5,I6,I7,I8"); next}
{print_opcode($0, "")}