//===-- PPC.h - Top-level interface for PowerPC Target ----------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains the entry points for global functions defined in the LLVM
// PowerPC back-end.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_POWERPC_PPC_H
#define LLVM_LIB_TARGET_POWERPC_PPC_H

#include "llvm/Support/CodeGen.h"

// GCC #defines PPC on Linux but we use it as our namespace name
#undef PPC

namespace llvm {
  class PPCTargetMachine;
  class PassRegistry;
  class FunctionPass;
  class MachineInstr;
  class MachineOperand;
  class AsmPrinter;
  class MCInst;
  class MCOperand;
  class ModulePass;
  
  FunctionPass *createPPCCTRLoops();
#ifndef NDEBUG
  FunctionPass *createPPCCTRLoopsVerify();
#endif
  FunctionPass *createPPCLoopInstrFormPrepPass(PPCTargetMachine &TM);
  FunctionPass *createPPCTOCRegDepsPass();
  FunctionPass *createPPCEarlyReturnPass();
  FunctionPass *createPPCVSXCopyPass();
  FunctionPass *createPPCVSXFMAMutatePass();
  FunctionPass *createPPCVSXSwapRemovalPass();
  FunctionPass *createPPCReduceCRLogicalsPass();
  FunctionPass *createPPCMIPeepholePass();
  FunctionPass *createPPCBranchSelectionPass();
  FunctionPass *createPPCBranchCoalescingPass();
  FunctionPass *createPPCQPXLoadSplatPass();
  FunctionPass *createPPCISelDag(PPCTargetMachine &TM, CodeGenOpt::Level OL);
  FunctionPass *createPPCTLSDynamicCallPass();
  FunctionPass *createPPCBoolRetToIntPass();
  FunctionPass *createPPCExpandISELPass();
  FunctionPass *createPPCPreEmitPeepholePass();
  // new pass
  FunctionPass *createPPCMachineBBedgePass();
  FunctionPass *createPPCMachineBBPrinterPass();
  FunctionPass *createPPCMachineBBdetailPass();
  FunctionPass *createPPCMachineBBlocPass();
  FunctionPass *createPPCMachineIRDumperPass();

  void LowerPPCMachineInstrToMCInst(const MachineInstr *MI, MCInst &OutMI,
                                    AsmPrinter &AP, bool IsDarwin);
  bool LowerPPCMachineOperandToMCOperand(const MachineOperand &MO,
                                         MCOperand &OutMO, AsmPrinter &AP,
                                         bool IsDarwin);

  void initializePPCCTRLoopsPass(PassRegistry&);
#ifndef NDEBUG
  void initializePPCCTRLoopsVerifyPass(PassRegistry&);
#endif
  void initializePPCLoopInstrFormPrepPass(PassRegistry&);
  void initializePPCTOCRegDepsPass(PassRegistry&);
  void initializePPCEarlyReturnPass(PassRegistry&);
  void initializePPCVSXCopyPass(PassRegistry&);
  void initializePPCVSXFMAMutatePass(PassRegistry&);
  void initializePPCVSXSwapRemovalPass(PassRegistry&);
  void initializePPCReduceCRLogicalsPass(PassRegistry&);
  void initializePPCBSelPass(PassRegistry&);
  void initializePPCBranchCoalescingPass(PassRegistry&);
  void initializePPCQPXLoadSplatPass(PassRegistry&);
  void initializePPCBoolRetToIntPass(PassRegistry&);
  void initializePPCExpandISELPass(PassRegistry &);
  void initializePPCPreEmitPeepholePass(PassRegistry &);
  void initializePPCTLSDynamicCallPass(PassRegistry &);
  void initializePPCMIPeepholePass(PassRegistry&);
  // new pass
  void initializePPCMachineBBedgePass(PassRegistry&);
  void initializePPCMachineBBPrinterPass(PassRegistry&);
  void initializePPCMachineBBdetailPass(PassRegistry&);
  void initializePPCMachineBBlocPass(PassRegistry&);
  void initializePPCMachineIRDumperPass(PassRegistry&);

  extern char &PPCVSXFMAMutateID;

  ModulePass *createPPCLowerMASSVEntriesPass();
  void initializePPCLowerMASSVEntriesPass(PassRegistry &);
  extern char &PPCLowerMASSVEntriesID;
  
  namespace PPCII {

  /// Target Operand Flag enum.
  enum TOF {
    //===------------------------------------------------------------------===//
    // PPC Specific MachineOperand flags.
    MO_NO_FLAG,

    /// On a symbol operand "FOO", this indicates that the reference is actually
    /// to "FOO@plt".  This is used for calls and jumps to external functions
    /// and for PIC calls on 32-bit ELF systems.
    MO_PLT = 1,

    /// MO_PIC_FLAG - If this bit is set, the symbol reference is relative to
    /// the function's picbase, e.g. lo16(symbol-picbase).
    MO_PIC_FLAG = 2,

    /// MO_NLP_FLAG - If this bit is set, the symbol reference is actually to
    /// the non_lazy_ptr for the global, e.g. lo16(symbol$non_lazy_ptr-picbase).
    MO_NLP_FLAG = 4,

    /// MO_NLP_HIDDEN_FLAG - If this bit is set, the symbol reference is to a
    /// symbol with hidden visibility.  This causes a different kind of
    /// non-lazy-pointer to be generated.
    MO_NLP_HIDDEN_FLAG = 8,

    /// The next are not flags but distinct values.
    MO_ACCESS_MASK = 0xf0,

    /// MO_LO, MO_HA - lo16(symbol) and ha16(symbol)
    MO_LO = 1 << 4,
    MO_HA = 2 << 4,

    MO_TPREL_LO = 4 << 4,
    MO_TPREL_HA = 3 << 4,

    /// These values identify relocations on immediates folded
    /// into memory operations.
    MO_DTPREL_LO = 5 << 4,
    MO_TLSLD_LO = 6 << 4,
    MO_TOC_LO = 7 << 4,

    // Symbol for VK_PPC_TLS fixup attached to an ADD instruction
    MO_TLS = 8 << 4
  };
  } // end namespace PPCII

} // end namespace llvm;

#endif
