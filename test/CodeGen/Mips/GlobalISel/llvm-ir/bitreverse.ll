; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -mtriple=mipsel-linux-gnu -global-isel -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32
; RUN: llc -O0 -mtriple=mipsel-linux-gnu -global-isel -mattr=+mips32r2 -verify-machineinstrs %s -o -| FileCheck %s -check-prefixes=MIPS32R2

declare i32 @llvm.bitreverse.i32(i32)
define i32 @bitreverse_i32(i32 signext %a) {
; MIPS32-LABEL: bitreverse_i32:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    sll $1, $4, 24
; MIPS32-NEXT:    srl $2, $4, 24
; MIPS32-NEXT:    or $1, $2, $1
; MIPS32-NEXT:    andi $2, $4, 65280
; MIPS32-NEXT:    sll $2, $2, 8
; MIPS32-NEXT:    or $1, $1, $2
; MIPS32-NEXT:    srl $2, $4, 8
; MIPS32-NEXT:    andi $2, $2, 65280
; MIPS32-NEXT:    or $1, $1, $2
; MIPS32-NEXT:    lui $2, 61680
; MIPS32-NEXT:    ori $2, $2, 61680
; MIPS32-NEXT:    and $3, $1, $2
; MIPS32-NEXT:    srl $3, $3, 4
; MIPS32-NEXT:    sll $1, $1, 4
; MIPS32-NEXT:    and $1, $1, $2
; MIPS32-NEXT:    or $1, $3, $1
; MIPS32-NEXT:    lui $2, 52428
; MIPS32-NEXT:    ori $2, $2, 52428
; MIPS32-NEXT:    and $3, $1, $2
; MIPS32-NEXT:    srl $3, $3, 2
; MIPS32-NEXT:    sll $1, $1, 2
; MIPS32-NEXT:    and $1, $1, $2
; MIPS32-NEXT:    or $1, $3, $1
; MIPS32-NEXT:    lui $2, 43690
; MIPS32-NEXT:    ori $2, $2, 43690
; MIPS32-NEXT:    and $3, $1, $2
; MIPS32-NEXT:    srl $3, $3, 1
; MIPS32-NEXT:    sll $1, $1, 1
; MIPS32-NEXT:    and $1, $1, $2
; MIPS32-NEXT:    or $2, $3, $1
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
;
; MIPS32R2-LABEL: bitreverse_i32:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    wsbh $1, $4
; MIPS32R2-NEXT:    rotr $1, $1, 16
; MIPS32R2-NEXT:    lui $2, 61680
; MIPS32R2-NEXT:    ori $2, $2, 61680
; MIPS32R2-NEXT:    and $3, $1, $2
; MIPS32R2-NEXT:    srl $3, $3, 4
; MIPS32R2-NEXT:    sll $1, $1, 4
; MIPS32R2-NEXT:    and $1, $1, $2
; MIPS32R2-NEXT:    or $1, $3, $1
; MIPS32R2-NEXT:    lui $2, 52428
; MIPS32R2-NEXT:    ori $2, $2, 52428
; MIPS32R2-NEXT:    and $3, $1, $2
; MIPS32R2-NEXT:    srl $3, $3, 2
; MIPS32R2-NEXT:    sll $1, $1, 2
; MIPS32R2-NEXT:    and $1, $1, $2
; MIPS32R2-NEXT:    or $1, $3, $1
; MIPS32R2-NEXT:    lui $2, 43690
; MIPS32R2-NEXT:    ori $2, $2, 43690
; MIPS32R2-NEXT:    and $3, $1, $2
; MIPS32R2-NEXT:    srl $3, $3, 1
; MIPS32R2-NEXT:    sll $1, $1, 1
; MIPS32R2-NEXT:    and $1, $1, $2
; MIPS32R2-NEXT:    or $2, $3, $1
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    nop
entry:
  %0 = call i32 @llvm.bitreverse.i32(i32 %a)
  ret i32 %0
}

declare i64 @llvm.bitreverse.i64(i64)
define i64 @bitreverse_i64(i64 signext %a) {
; MIPS32-LABEL: bitreverse_i64:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    sll $1, $5, 24
; MIPS32-NEXT:    srl $2, $5, 24
; MIPS32-NEXT:    or $1, $2, $1
; MIPS32-NEXT:    andi $2, $5, 65280
; MIPS32-NEXT:    sll $2, $2, 8
; MIPS32-NEXT:    or $1, $1, $2
; MIPS32-NEXT:    srl $2, $5, 8
; MIPS32-NEXT:    andi $2, $2, 65280
; MIPS32-NEXT:    or $1, $1, $2
; MIPS32-NEXT:    lui $2, 61680
; MIPS32-NEXT:    ori $2, $2, 61680
; MIPS32-NEXT:    and $3, $1, $2
; MIPS32-NEXT:    srl $3, $3, 4
; MIPS32-NEXT:    sll $1, $1, 4
; MIPS32-NEXT:    and $1, $1, $2
; MIPS32-NEXT:    or $1, $3, $1
; MIPS32-NEXT:    lui $3, 52428
; MIPS32-NEXT:    ori $3, $3, 52428
; MIPS32-NEXT:    and $5, $1, $3
; MIPS32-NEXT:    srl $5, $5, 2
; MIPS32-NEXT:    sll $1, $1, 2
; MIPS32-NEXT:    and $1, $1, $3
; MIPS32-NEXT:    or $1, $5, $1
; MIPS32-NEXT:    lui $5, 43690
; MIPS32-NEXT:    ori $5, $5, 43690
; MIPS32-NEXT:    and $6, $1, $5
; MIPS32-NEXT:    srl $6, $6, 1
; MIPS32-NEXT:    sll $1, $1, 1
; MIPS32-NEXT:    and $1, $1, $5
; MIPS32-NEXT:    or $1, $6, $1
; MIPS32-NEXT:    sll $6, $4, 24
; MIPS32-NEXT:    srl $7, $4, 24
; MIPS32-NEXT:    or $6, $7, $6
; MIPS32-NEXT:    andi $7, $4, 65280
; MIPS32-NEXT:    sll $7, $7, 8
; MIPS32-NEXT:    or $6, $6, $7
; MIPS32-NEXT:    srl $4, $4, 8
; MIPS32-NEXT:    andi $4, $4, 65280
; MIPS32-NEXT:    or $4, $6, $4
; MIPS32-NEXT:    and $6, $4, $2
; MIPS32-NEXT:    srl $6, $6, 4
; MIPS32-NEXT:    sll $4, $4, 4
; MIPS32-NEXT:    and $2, $4, $2
; MIPS32-NEXT:    or $2, $6, $2
; MIPS32-NEXT:    and $4, $2, $3
; MIPS32-NEXT:    srl $4, $4, 2
; MIPS32-NEXT:    sll $2, $2, 2
; MIPS32-NEXT:    and $2, $2, $3
; MIPS32-NEXT:    or $2, $4, $2
; MIPS32-NEXT:    and $3, $2, $5
; MIPS32-NEXT:    srl $3, $3, 1
; MIPS32-NEXT:    sll $2, $2, 1
; MIPS32-NEXT:    and $2, $2, $5
; MIPS32-NEXT:    or $3, $3, $2
; MIPS32-NEXT:    move $2, $1
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    nop
;
; MIPS32R2-LABEL: bitreverse_i64:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    wsbh $1, $5
; MIPS32R2-NEXT:    rotr $1, $1, 16
; MIPS32R2-NEXT:    lui $2, 61680
; MIPS32R2-NEXT:    ori $2, $2, 61680
; MIPS32R2-NEXT:    and $3, $1, $2
; MIPS32R2-NEXT:    srl $3, $3, 4
; MIPS32R2-NEXT:    sll $1, $1, 4
; MIPS32R2-NEXT:    and $1, $1, $2
; MIPS32R2-NEXT:    or $1, $3, $1
; MIPS32R2-NEXT:    lui $3, 52428
; MIPS32R2-NEXT:    ori $3, $3, 52428
; MIPS32R2-NEXT:    and $5, $1, $3
; MIPS32R2-NEXT:    srl $5, $5, 2
; MIPS32R2-NEXT:    sll $1, $1, 2
; MIPS32R2-NEXT:    and $1, $1, $3
; MIPS32R2-NEXT:    or $1, $5, $1
; MIPS32R2-NEXT:    lui $5, 43690
; MIPS32R2-NEXT:    ori $5, $5, 43690
; MIPS32R2-NEXT:    and $6, $1, $5
; MIPS32R2-NEXT:    srl $6, $6, 1
; MIPS32R2-NEXT:    sll $1, $1, 1
; MIPS32R2-NEXT:    and $1, $1, $5
; MIPS32R2-NEXT:    or $1, $6, $1
; MIPS32R2-NEXT:    wsbh $4, $4
; MIPS32R2-NEXT:    rotr $4, $4, 16
; MIPS32R2-NEXT:    and $6, $4, $2
; MIPS32R2-NEXT:    srl $6, $6, 4
; MIPS32R2-NEXT:    sll $4, $4, 4
; MIPS32R2-NEXT:    and $2, $4, $2
; MIPS32R2-NEXT:    or $2, $6, $2
; MIPS32R2-NEXT:    and $4, $2, $3
; MIPS32R2-NEXT:    srl $4, $4, 2
; MIPS32R2-NEXT:    sll $2, $2, 2
; MIPS32R2-NEXT:    and $2, $2, $3
; MIPS32R2-NEXT:    or $2, $4, $2
; MIPS32R2-NEXT:    and $3, $2, $5
; MIPS32R2-NEXT:    srl $3, $3, 1
; MIPS32R2-NEXT:    sll $2, $2, 1
; MIPS32R2-NEXT:    and $2, $2, $5
; MIPS32R2-NEXT:    or $3, $3, $2
; MIPS32R2-NEXT:    move $2, $1
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    nop
entry:
  %0 = call i64 @llvm.bitreverse.i64(i64 %a)
  ret i64 %0
}
