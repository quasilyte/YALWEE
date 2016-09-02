#include <stdio.h>
#include <stdlib.h>

extern int eval(const char* code);

#define EXIT "\x00\x00"
#define ACC_ADD_R1 "\x01\x00"
#define ACC_ADD_R2 "\x02\x00"

#define IACC_LOAD_R1 "\x03\x00"
#define IACC_LOAD_R2 "\x04\x00"
#define IACC_SAVE_R1 "\x05\x00"
#define IACC_SAVE_R2 "\x06\x00"
#define IRESET_R0 "\x07\x00"
#define IRESET_R1 "\x08\x00"
#define IRESET_R2 "\x09\x00"
#define IMOVE_R0_TO_R1 "\x0A\x00"
#define IMOVE_R0_TO_R2 "\x0B\x00"
#define IMOVE_R1_TO_R0 "\x0C\x00"
#define IMOVE_R1_TO_R2 "\x0D\x00"
#define IMOVE_R2_TO_R0 "\x0E\x00"
#define IMOVE_R2_TO_R1 "\x0F\x00"
#define IMOVE_8_TO_R0(BYTE) "\x10\x00" BYTE
#define IMOVE_8_TO_R1(BYTE) "\x11\x00" BYTE
#define IMOVE_8_TO_R2(BYTE) "\x12\x00" BYTE
#define IJMPZ_R0(POS) "\x13\x00" POS
#define IJMPZ_R1(POS) "\x14\x00" POS
#define IJMPZ_R2(POS) "\x15\x00" POS
#define IADD_8_TO_R0(BYTE) "\x16\x00" BYTE
#define IADD_8_TO_R1(BYTE) "\x17\x00" BYTE
#define IADD_8_TO_R2(BYTE) "\x18\x00" BYTE
#define IMOVE_32_TO_R0(DWORD) "\x19\x00" DWORD
#define IMOVE_32_TO_R1(DWORD) "\x1A\x00" DWORD
#define IMOVE_32_TO_R2(DWORD) "\x1B\x00" DWORD
#define IDEC_R0 "\x1C\x00"
#define IDEC_R1 "\x1D\x00"
#define IDEC_R2 "\x1E\x00"
#define IINC_R0 "\x1F\x00"
#define IINC_R1 "\x20\x00"
#define IINC_R2 "\x21\x00"
#define IJMPNZ_R0(POS) "\x22\x00" POS
#define IJMPNZ_R1(POS) "\x23\x00" POS
#define IJMPNZ_R2(POS) "\x24\x00" POS

void read_regs(long* dest) {
  long value;
  
  __asm("mov %%r8, %0" :"=r" (value));
  dest[0] = value;
  __asm("mov %%r9, %0" :"=r" (value));
  dest[1] = value;
  __asm("mov %%r10, %0" :"=r" (value));
  dest[2] = value;
}

void set_ir(int n, long value) {
  switch (n) {
  case 0: 
    __asm("mov %0, %%r8\n" ::"r" (value));
    return;  
  case 1: 
    __asm("mov %0, %%r9\n" ::"r" (value));
    return; 
  case 2: 
    __asm("mov %0, %%r10\n" ::"r" (value));
    return; 
  }
}

void reset_regs(void) {
  __asm(
    "xor %r8, %r8\n"
    "xor %r9, %r9\n"
    "xor %r10, %r10\n"
  );
}

extern int foo;

/*
long score = 0;
int i = 999999;
do {
  score += 2;
  i -= 1;
} while (i != 0);
*/

/*
mov ecx, N 
    jmp bottom
top:
    BODY
    dec ecx
bottom:
    cmp ecx, 0
    jne top
*/
const char* loop_code =  ""
  // ir[0] -- score
  // ir[1] -- i (inductive variable)
  // 2 fa f0 7f "\x7f\x96\x98\x00"
  /*00*/ IMOVE_32_TO_R1("\x7f\xf0\xfa\x02")
  /*06*/ IADD_8_TO_R0("\x02") 
  // # need loop opcode? dec+jmp
  /*09*/ IDEC_R1
  /*11*/ IJMPNZ_R1("\x06\x00\x00\x00\x00\x00\x00\x00")
  /*21*/ EXIT
  ;

const char* code = 
  ACC_ADD_R1
  ACC_ADD_R2
  EXIT;

extern const char* code_root;

int main() {
  reset_regs();

  // set_ir(1, 10);
  set_ir(2, 15);

  eval(code);
  
  long irs[3];
  read_regs(irs);

  for (int i = 0; i < 3; ++i) {
    printf("ir[%d] = %ld\n", i, irs[i]);
  }
  
  return 0;
}
