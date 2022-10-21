//
// Copyright (c) 2022 Imperas Software Ltd., www.imperas.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied.
//
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
 


typedef enum {
    dyn,
    rdn,
    rmm,
    rne,
    rtz,
    rup
} frm_name_t;

function frm_name_t get_frm(string s, asm); 
    case (s)
        "rdn": return rdn;
        "rmm": return rmm;
        "rne": return rne;
        "rtz": return rtz;
        "rup": return rup;
        default: return dyn;
    endcase
endfunction


typedef struct {
    string ins_str;
    //instr_name_t asm;
    ops_t ops[5];
    int hart;
    int issue;
} ins_rv32f_t;


covergroup fadd_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fadd.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FADD-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FADD-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FADD-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[3].val, "FADD-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FADD-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FADD-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FADD-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FADD-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fclass_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fclass.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "FCLASS-S") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FCLASS-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
endgroup

covergroup fcvt_s_w_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fcvt.s.w" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FCVT-S-W") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_rs1 : coverpoint get_gpr_reg(ins.ops[1].key, "FCVT-S-W") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[2].val, "FCVT-S-W") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FCVT-S-W") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FCVT-S-W") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FCVT-S-W") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FCVT-S-W") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fcvt_s_wu_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fcvt.s.wu" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FCVT-S-WU") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_rs1 : coverpoint get_gpr_reg(ins.ops[1].key, "FCVT-S-WU") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[2].val, "FCVT-S-WU") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FCVT-S-WU") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FCVT-S-WU") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FCVT-S-WU") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FCVT-S-WU") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fcvt_w_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fcvt.w.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "FCVT-W-S") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FCVT-W-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[2].val, "FCVT-W-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FCVT-W-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FCVT-W-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FCVT-W-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FCVT-W-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fcvt_wu_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fcvt.wu.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "FCVT-WU-S") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FCVT-WU-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[2].val, "FCVT-WU-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FCVT-WU-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FCVT-WU-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FCVT-WU-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FCVT-WU-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fdiv_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fdiv.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FDIV-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FDIV-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FDIV-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[3].val, "FDIV-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FDIV-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FDIV-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FDIV-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FDIV-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup feq_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "feq.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "FEQ-S") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FEQ-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FEQ-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
endgroup

covergroup fle_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fle.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "FLE-S") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FLE-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FLE-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
endgroup

covergroup flt_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "flt.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "FLT-S") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FLT-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FLT-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
endgroup

covergroup flw_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "flw" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FLW") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_rs1 : coverpoint get_gpr_reg(ins.ops[2].key, "FLW") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
    cp_imm_sign : coverpoint get_imm(ins.ops[1].key, "FLW") {
        option.comment = "Immediate value sign";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup

covergroup fmadd_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fmadd.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FMADD-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FMADD-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FMADD-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
    cp_fs3 : coverpoint get_fpr_reg(ins.ops[3].key, "FMADD-S") {
        option.comment = "FS3 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[4].val, "FMADD-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FMADD-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FMADD-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FMADD-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FMADD-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fmax_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fmax.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FMAX-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FMAX-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FMAX-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
endgroup

covergroup fmin_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fmin.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FMIN-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FMIN-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FMIN-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
endgroup

covergroup fmsub_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fmsub.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FMSUB-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FMSUB-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FMSUB-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
    cp_fs3 : coverpoint get_fpr_reg(ins.ops[3].key, "FMSUB-S") {
        option.comment = "FS3 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[4].val, "FMSUB-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FMSUB-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FMSUB-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FMSUB-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FMSUB-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fmul_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fmul.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FMUL-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FMUL-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FMUL-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[3].val, "FMUL-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FMUL-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FMUL-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FMUL-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FMUL-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fmv_w_x_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fmv.w.x" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
endgroup

covergroup fmv_x_w_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fmv.x.w" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
endgroup

covergroup fnmadd_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fnmadd.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FNMADD-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FNMADD-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FNMADD-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
    cp_fs3 : coverpoint get_fpr_reg(ins.ops[3].key, "FNMADD-S") {
        option.comment = "FS3 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[4].val, "FNMADD-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FNMADD-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FNMADD-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FNMADD-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FNMADD-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fnmsub_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fnmsub.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FNMSUB-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FNMSUB-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FNMSUB-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
    cp_fs3 : coverpoint get_fpr_reg(ins.ops[3].key, "FNMSUB-S") {
        option.comment = "FS3 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[4].val, "FNMSUB-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FNMSUB-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FNMSUB-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FNMSUB-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FNMSUB-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fsgnj_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fsgnj.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FSGNJ-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FSGNJ-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FSGNJ-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
endgroup

covergroup fsgnjn_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fsgnjn.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FSGNJN-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FSGNJN-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FSGNJN-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
endgroup

covergroup fsgnjx_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fsgnjx.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FSGNJX-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FSGNJX-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FSGNJX-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
endgroup

covergroup fsqrt_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fsqrt.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FSQRT-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FSQRT-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[2].val, "FSQRT-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FSQRT-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FSQRT-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FSQRT-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FSQRT-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fsub_s_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fsub.s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fd : coverpoint get_fpr_reg(ins.ops[0].key, "FSUB-S") {
        option.comment = "FD (FPR) register assignment";
    }
    
    cp_fs1 : coverpoint get_fpr_reg(ins.ops[1].key, "FSUB-S") {
        option.comment = "FS1 (FPR) register assignment";
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[2].key, "FSUB-S") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
    cp_frm : coverpoint get_frm(ins.ops[3].val, "FSUB-S") {
        option.comment = "Floating Point FRM (Rounding mode) given as an operand";
    }
    
    cp_csr_fcsr_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "fcsr", "frm", "FSUB-S") {
        option.comment = "Value of fcsr CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fcsr_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fcsr", "fflags", "FSUB-S") {
        option.comment = "Value of fcsr CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
    cp_csr_frm_frm : coverpoint get_csr_val(ins.hart, ins.issue, 1, "frm", "frm", "FSUB-S") {
        option.comment = "Value of frm CSR, frm field";
        bins rne  = {3'b000};
        bins rtz  = {3'b001};
        bins rdn  = {3'b010};
        bins rup  = {3'b011};
        bins rmm  = {3'b100};
        bins illegal  = default;
    }
    
    cp_csr_fflags_fflags : coverpoint get_csr_val(ins.hart, ins.issue, 0, "fflags", "fflags", "FSUB-S") {
        option.comment = "Value of fflags CSR, fflags field";
        wildcard bins NX  = {5'b????1};
        wildcard bins UF  = {5'b???1?};
        wildcard bins OF  = {5'b??1??};
        wildcard bins DZ  = {5'b?1???};
        wildcard bins NV  = {5'b1????};
    }
    
endgroup

covergroup fsw_cg with function sample(ins_rv32f_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "fsw" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_fs2 : coverpoint get_fpr_reg(ins.ops[0].key, "FSW") {
        option.comment = "FS2 (FPR) register assignment";
    }
    
    cp_rs1 : coverpoint get_gpr_reg(ins.ops[2].key, "FSW") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
    cp_imm_sign : coverpoint get_imm(ins.ops[1].key, "FSW") {
        option.comment = "Immediate value sign";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup


function ins_rv32f_t get_rv32f_inst(bit trap, int hart, int issue, string disass); // break and move this first bit out
    string insbin, ins_str, op[4], key, val;
    ins_rv32f_t ins;
    int num, i, j;
    string s = disass;
    foreach (disass[c]) begin
        s[c] = (disass[c] == ",")? " " : disass[c];
    end
    ins.hart = hart;
    ins.issue = issue;
    num = $sscanf (s, "%s %s %s %s %s %s %s %s", insbin, ins_str, op[0], op[1], op[2], op[3], op[4], op[5]);
    ins.ins_str = ins_str;
    //$display("num(%d) ins_str(%s) op[0](%0s) op[1](%s) op[2](%s) op[3](%s)", num, ins_str, op[0], op[1], op[2], op[3]);
    for (i=0; i<num-2; i++) begin
        key = op[i];
        ins.ops[i].key=op[i]; // in case we dont update it as an indexed
        ins.ops[i].val=""; // not used
        for (j = 0; j < key.len(); j++) begin // if indexed addressing, convert offset(rs1) to op[i].key=rs1 op[i+1].key=offset
            if (key[j] == "(") begin
                ins.ops[i].key = key.substr(0,j-1); // offset
                ins.ops[i+1].key = key.substr(j+1,key.len()-2);
                i++; // step over +1
                //$display("indirect ins_str(%s) op[0](%0s).key(%s) op[1](%s).key(%s) op[2](%s).key(%s) op[3](%s).key(%s)", 
                //    ins_str, op[0], ins.ops[0].key, op[1], ins.ops[1].key, op[2], ins.ops[2].key, op[3], ins.ops[3].key);
                break;
            end
        end
    end
    for (i=0; i<num-2; i++) begin
        if (ins.ops[i].key[0] == "x") begin
            int idx = get_gpr_num(ins.ops[i].key);
            //$display("SAMPLE: %0s op[%0d]=%0s gpr(%0d)", ins_str,i, ins.ops[i].key, idx);
            if (idx < 0) begin
                ins.ops[i].val = ins.ops[i].key; // it is an immed already there
            end else begin
                ins.ops[i].val = string'(this.rvvi.x_wdata[hart][issue][idx]);
            end
        end else if (ins.ops[i].key[0] == "f") begin
            int idx = get_fpr_num(ins.ops[i].key);
            if (idx < 0) begin
                ins.ops[i].val = ins.ops[i].key; // it is an immed already there
            end else begin
                ins.ops[i].val = string'(this.rvvi.f_wdata[hart][issue][idx]);
            end
        end else begin
            ins.ops[i].val = ins.ops[i].key;
        end       
    end
    return ins;
endfunction

function void rv32f_sample(string inst_name, bit trap, int hart, int issue, string disass);
    case (inst_name)
        "fadd.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fadd_s_cg.sample(ins); end
        "fclass.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fclass_s_cg.sample(ins); end
        "fcvt.s.w"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fcvt_s_w_cg.sample(ins); end
        "fcvt.s.wu"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fcvt_s_wu_cg.sample(ins); end
        "fcvt.w.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fcvt_w_s_cg.sample(ins); end
        "fcvt.wu.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fcvt_wu_s_cg.sample(ins); end
        "fdiv.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fdiv_s_cg.sample(ins); end
        "feq.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); feq_s_cg.sample(ins); end
        "fle.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fle_s_cg.sample(ins); end
        "flt.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); flt_s_cg.sample(ins); end
        "flw"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); flw_cg.sample(ins); end
        "fmadd.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fmadd_s_cg.sample(ins); end
        "fmax.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fmax_s_cg.sample(ins); end
        "fmin.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fmin_s_cg.sample(ins); end
        "fmsub.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fmsub_s_cg.sample(ins); end
        "fmul.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fmul_s_cg.sample(ins); end
        "fmv.w.x"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fmv_w_x_cg.sample(ins); end
        "fmv.x.w"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fmv_x_w_cg.sample(ins); end
        "fnmadd.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fnmadd_s_cg.sample(ins); end
        "fnmsub.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fnmsub_s_cg.sample(ins); end
        "fsgnj.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fsgnj_s_cg.sample(ins); end
        "fsgnjn.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fsgnjn_s_cg.sample(ins); end
        "fsgnjx.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fsgnjx_s_cg.sample(ins); end
        "fsqrt.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fsqrt_s_cg.sample(ins); end
        "fsub.s"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fsub_s_cg.sample(ins); end
        "fsw"     : begin ins_rv32f_t ins = get_rv32f_inst(trap, hart, issue, disass); fsw_cg.sample(ins); end
    endcase
endfunction


