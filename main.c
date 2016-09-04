#include <stdio.h>
#include <stdlib.h>

extern int eval(const char* code);

#define EXIT 0, 0
#define ACC_ADD_R1 1, 0
#define ACC_ADD_R2 2, 0
#define ACC_LOAD_R1 3, 0
#define ACC_LOAD_R2 4, 0
#define ACC_SAVE_R1 5, 0
#define ACC_SAVE_R2 6, 0
#define RESET_R0 7, 0
#define RESET_R1 8, 0
#define RESET_R2 9, 0
#define INC_R0 10, 0
#define INC_R1 11, 0
#define INC_R2 12, 0
#define DEC_R0 13, 0
#define DEC_R1 14, 0
#define DEC_R2 15, 0
#define MOVE_8_TO_R0(BYTE) 16, 0, BYTE
#define MOVE_8_TO_R1(BYTE) 17, 0, BYTE
#define MOVE_8_TO_R2(BYTE) 18, 0, BYTE
#define MOVE_COUNTER_TO_R0 19, 0
#define MOVE_COUNTER_TO_R1 20, 0
#define MOVE_COUNTER_TO_R2 21, 0
#define REPEAT32(BYTE1, BYTE2, BYTE3, BYTE4, JMP) 22, 0, BYTE1, BYTE2, BYTE3, BYTE4, JMP
#define REPEAT8(BYTE) 22, 0, BYTE
#define ADD_8_TO_R0(BYTE) 23, 0, BYTE
#define ADD_8_TO_R1(BYTE) 24, 0, BYTE
#define ADD_8_TO_R2(BYTE) 25, 0, BYTE
#define NEXT_OP 26, 0
// #define REPEAT8(BYTE) 22, 0, BYTE

// #define IMOVE_R0_TO_R1 "\x0A\x00"
// #define IMOVE_R0_TO_R2 "\x0B\x00"
// #define IMOVE_R1_TO_R0 "\x0C\x00"
// #define IMOVE_R1_TO_R2 "\x0D\x00"
// #define IMOVE_R2_TO_R0 "\x0E\x00"
// #define IMOVE_R2_TO_R1 "\x0F\x00"
// #define IMOVE_8_TO_R0(BYTE) "\x10\x00" BYTE
// #define IMOVE_8_TO_R1(BYTE) "\x11\x00" BYTE
// #define IMOVE_8_TO_R2(BYTE) "\x12\x00" BYTE
// #define IJMPZ_R0(POS) "\x13\x00" POS
// #define IJMPZ_R1(POS) "\x14\x00" POS
// #define IJMPZ_R2(POS) "\x15\x00" POS
// #define IADD_8_TO_R0(BYTE) "\x16\x00" BYTE
// #define IADD_8_TO_R1(BYTE) "\x17\x00" BYTE
// #define IADD_8_TO_R2(BYTE) "\x18\x00" BYTE
// #define IMOVE_32_TO_R0(DWORD) "\x19\x00" DWORD
// #define IMOVE_32_TO_R1(DWORD) "\x1A\x00" DWORD
// #define IMOVE_32_TO_R2(DWORD) "\x1B\x00" DWORD
// #define IDEC_R0 "\x1C\x00"
// #define IDEC_R1 "\x1D\x00"
// #define IDEC_R2 "\x1E\x00"
// #define IINC_R0 "\x1F\x00"
// #define IINC_R1 "\x20\x00"
// #define IINC_R2 "\x21\x00"
// #define IJMPNZ_R0(POS) "\x22\x00" POS
// #define IJMPNZ_R1(POS) "\x23\x00" POS
// #define IJMPNZ_R2(POS) "\x24\x00" POS

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
// const char* loop_code =  ""
//   // ir[0] -- score
//   // ir[1] -- i (inductive variable)
//   // 2 fa f0 7f "\x7f\x96\x98\x00"
//   /*00*/ IMOVE_32_TO_R1("\x7f\xf0\xfa\x02")
//   /*06*/ IADD_8_TO_R0("\x02") 
//   // # need loop opcode? dec+jmp
//   /*09*/ IDEC_R1
//   /*11*/ IJMPNZ_R1("\x06\x00\x00\x00\x00\x00\x00\x00")
//   /*21*/ EXIT
  ;

/*
1 loop:
- push rcx
- push loop head addr
1 iter:
- compare counter with 0
- jump to loop_body
- set PC to the loop_head
- push return addr
- jmp to recursive eval
  - nested eval
- decrement counter value
*/

// const char code[] = { 
//   REPEAT32(0x7f, 0x96, 0x98, 0x00),
//     REPEAT32(1, 0, 0, 0),
//       ADD_8_TO_R0(2),
//     NEXT_OP,
//   NEXT_OP,
//   // EXIT,
//   // EXIT,

//   EXIT
// };

/*
[][] [][][][] [x] -> 
  [][] [][][][] [x]
    [][] []
    [][] []
    [][] []
    [][] []
  [][]
[][]

*/

const char code[] = { 
  REPEAT32(0x7f, 0x96, 0x98, 0x00, 27),
    REPEAT32(5, 0, 0, 0, 18),
      ADD_8_TO_R0(2),
      ADD_8_TO_R0(3),
      ADD_8_TO_R0(4),
      ADD_8_TO_R0(5),
      ADD_8_TO_R0(6),
    NEXT_OP,
  NEXT_OP,
  EXIT
};

// [][] [][][][] [x]
//   [][] [][][][] [x] -> 5
//     [][] inc_r0 
//   [][] next_op
// [][] next_op
// [][] inc_r1
// [][] exit

// const char code[] = { 
//   REPEAT32(2, 0, 0, 0, 14), // 2 + {4} + 1 | 0
//     REPEAT32(1, 0, 0, 0, 5),
//       INC_R0, // 2 | 7
//     NEXT_OP, 
//   NEXT_OP, // 2 | 9
//   INC_R1, // 2 | 11

//   EXIT, // 2 | 13
// };

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
