; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=-sse | FileCheck %s --check-prefix=X64-NOSSE
; RUN: llc < %s -mtriple=x86_64-linux-generic -verify-machineinstrs | FileCheck %s --check-prefix=X64-SSE

; Note: This test is testing that the lowering for atomics matches what we
; currently emit for non-atomics + the atomic restriction.  The presence of
; particular lowering detail in these tests should not be read as requiring
; that detail for correctness unless it's related to the atomicity itself.
; (Specifically, there were reviewer questions about the lowering for halfs
;  and their calling convention which remain unresolved.)

define void @store_fp128(fp128* %fptr, fp128 %v) {
; X64-NOSSE-LABEL: store_fp128:
; X64-NOSSE:       # %bb.0:
; X64-NOSSE-NEXT:    pushq %rax
; X64-NOSSE-NEXT:    .cfi_def_cfa_offset 16
; X64-NOSSE-NEXT:    callq __sync_lock_test_and_set_16
; X64-NOSSE-NEXT:    popq %rax
; X64-NOSSE-NEXT:    .cfi_def_cfa_offset 8
; X64-NOSSE-NEXT:    retq
;
; X64-SSE-LABEL: store_fp128:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    subq $24, %rsp
; X64-SSE-NEXT:    .cfi_def_cfa_offset 32
; X64-SSE-NEXT:    movaps %xmm0, (%rsp)
; X64-SSE-NEXT:    movq (%rsp), %rsi
; X64-SSE-NEXT:    movq {{[0-9]+}}(%rsp), %rdx
; X64-SSE-NEXT:    callq __sync_lock_test_and_set_16
; X64-SSE-NEXT:    addq $24, %rsp
; X64-SSE-NEXT:    .cfi_def_cfa_offset 8
; X64-SSE-NEXT:    retq
  store atomic fp128 %v, fp128* %fptr unordered, align 16
  ret void
}
