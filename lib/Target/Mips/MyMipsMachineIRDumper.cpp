#include "Mips.h"
#include "MipsInstrInfo.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/TargetRegisterInfo.h"
#include "llvm/Pass.h"
#include "llvm/IR/ModuleSlotTracker.h"
#include <string>
#include <map>
#include <list>
#include <set>
#include "MIRInfo.pb.h"
#include <fstream>
#include <ostream>

using namespace llvm;

// typedef std::list<std::tuple<std::string,unsigned,unsigned>> DebuginfoList;

#define Mips_MIR_DUMPER_PASS_NAME "Dummy Mips machineIR-Info dumper pass"

namespace {

class MipsMachineIRDumper : public MachineFunctionPass {
public:
    static char ID;

    MipsMachineIRDumper() : MachineFunctionPass(ID) { }
    
    bool runOnMachineFunction(MachineFunction &MF) override;
    bool doInitialization(Module &M) override;
    bool doFinalization(Module &M) override;

    StringRef getPassName() const override { return Mips_MIR_DUMPER_PASS_NAME; }
    
    mirpb::MIRFunctionBook MIR_Fs;

};

std::string getBBLabel(const llvm::BasicBlock *Node) {
    if (!Node) 
        return "NULL_BB";

    if (!Node->getName().empty()) {
        return Node->getName().str();
    }

    std::string Str;
    llvm::raw_string_ostream OS(Str);
    Node->printAsOperand(OS, false);
    return OS.str();
}

} // end of anonymous namespace

char MipsMachineIRDumper::ID = 0;

bool MipsMachineIRDumper::runOnMachineFunction(MachineFunction &MF) {

    unsigned MFID = MF.getFunctionNumber();
    std::string MFName = MF.getName();
    // outs() << MF.getName() << "\n";
    mirpb::MIRFunction *MFMsg = MIR_Fs.add_mfs();
    MFMsg->set_funcname(MFName);
    MFMsg->set_funcid(MFID);
    
    // repeated MIRBasicBlock MBBs
    for (auto &MBB : MF) {
        mirpb::MIRBasicBlock *MBBMsg = MFMsg->add_mbbs();
        std::string MBBID = std::to_string(MBB.getNumber());
        MBBMsg->set_mbblabel(MBBID);

        const BasicBlock *BB = MBB.getBasicBlock();
        std::string BBID;
        if (!BB) {
            BBID = "NULL_BB";
        } else {
            BBID = getBBLabel(BB);
        }
        MBBMsg->set_bblabel(BBID);
        
        // repeated MIRInst MIs
        for (auto &MI : MBB) {
            mirpb::MIRInst *MIMsg = MBBMsg->add_mis();
            
            std::string opcodeName = MI.getOpcodeName();
            MIMsg->set_opcode(opcodeName);

            // repeated string Oprand
            signed operandCount = MI.getNumOperands();
            if (operandCount){
                for(int i=0;i<operandCount;i++){
                    std::string operandName = MI.getOperand(i).getOperandName();
                    MIMsg->add_oprand(operandName);
                }
            }
            
            DebuginfoList DIL;
            bool status = false;
            MI.getDebugInfoTree(DIL, status);
            if (status) {
                for (auto &DebugInfo : DIL) {
                    mirpb::InstLoc *LocMsg = MIMsg->add_locs();
                    LocMsg->set_filename(std::get<0>(DebugInfo));
                    LocMsg->set_lineno(std::get<1>(DebugInfo));
                    LocMsg->set_colno(std::get<2>(DebugInfo));
                }
            }
        }
        
        // repeated string SuccMBBLabel
        for (MachineBasicBlock *S : MBB.successors()) {
            std::string SuccMBB = std::to_string(S->getNumber());
            MBBMsg->add_succmbblabel(SuccMBB); 
        }
        
    }

    return false;
}

bool MipsMachineIRDumper::doInitialization(Module &M) {
    // test protobuf
    GOOGLE_PROTOBUF_VERIFY_VERSION;
    return false;
}

bool MipsMachineIRDumper::doFinalization(Module &M) {
    outs() << "Starting output... \n";
    std::fstream output("./log", std::ios::out | std::ios::trunc | std::ios::binary);
    if (!MIR_Fs.SerializePartialToOstream(&output)) {
        outs() << "Failed to write msg. \n";
        output.close();
        return true;
    }
    output.close();
    outs() << "Finish of output. \n";
    return false;
}


INITIALIZE_PASS(MipsMachineIRDumper, "Mips-machineIR-dumper",
    Mips_MIR_DUMPER_PASS_NAME,
    true, // is CFG only?
    true  // is analysis?
)

namespace llvm {
// my-Mips-MIR-dumper
FunctionPass *createMipsMachineIRDumperPass() { return new MipsMachineIRDumper(); }

}