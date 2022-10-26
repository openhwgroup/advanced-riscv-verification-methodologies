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
 


typedef struct {
    string ins_str;
    //instr_name_t asm;
    ops_t ops[5];
    int hart;
    int issue;
} ins_rv32zca_t;


covergroup c_add_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.add" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "C-ADD") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_rs2 : coverpoint get_gpr_reg(ins.ops[1].key, "C-ADD") {
        option.comment = "RS2 (GPR) register assignment";
    }
    
    cp_rs2_sign : coverpoint int'(ins.ops[1].val) {
        option.comment = "RS2 (GPR) sign of value";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup

covergroup c_mv_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.mv" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "C-MV") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_rs2 : coverpoint get_gpr_reg(ins.ops[1].key, "C-MV") {
        option.comment = "RS2 (GPR) register assignment";
    }
    
    cp_rs2_sign : coverpoint int'(ins.ops[1].val) {
        option.comment = "RS2 (GPR) sign of value";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup

covergroup c_addi_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.addi" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "C-ADDI") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_imm_sign : coverpoint get_imm(ins.ops[1].key, "C-ADDI") {
        option.comment = "Immediate value sign";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup

covergroup c_addi16sp_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.addi16sp" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
endgroup

covergroup c_addi4spn_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.addi4spn" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
endgroup

covergroup c_li_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.li" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "C-LI") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_imm_sign : coverpoint get_imm(ins.ops[1].key, "C-LI") {
        option.comment = "Immediate value sign";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup

covergroup c_lui_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.lui" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "C-LUI") {
        option.comment = "RD (GPR) register assignment";
    }
    
endgroup

covergroup c_and_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.and" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rdp : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-AND") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_rs2p : coverpoint get_gpr_c_reg(ins.ops[1].key, "C-AND") {
        option.comment = "RS2 (GPR) register assignment";
    }
    
endgroup

covergroup c_or_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.or" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rdp : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-OR") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_rs2p : coverpoint get_gpr_c_reg(ins.ops[1].key, "C-OR") {
        option.comment = "RS2 (GPR) register assignment";
    }
    
endgroup

covergroup c_sub_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.sub" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rdp : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-SUB") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_rs2p : coverpoint get_gpr_c_reg(ins.ops[1].key, "C-SUB") {
        option.comment = "RS2 (GPR) register assignment";
    }
    
endgroup

covergroup c_xor_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.xor" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rdp : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-XOR") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_rs2p : coverpoint get_gpr_c_reg(ins.ops[1].key, "C-XOR") {
        option.comment = "RS2 (GPR) register assignment";
    }
    
endgroup

covergroup c_andi_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.andi" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rdp : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-ANDI") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_imm_sign : coverpoint get_imm(ins.ops[1].key, "C-ANDI") {
        option.comment = "Immediate value sign";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup

covergroup c_beqz_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.beqz" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_offset : coverpoint get_imm(ins.ops[1].key, "C-BEQZ") {
        option.comment = "Branch Immediate Offset value";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
    cp_rs1p : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-BEQZ") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
endgroup

covergroup c_bnez_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.bnez" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_offset : coverpoint get_imm(ins.ops[1].key, "C-BNEZ") {
        option.comment = "Branch Immediate Offset value";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
    cp_rs1p : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-BNEZ") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
endgroup

covergroup c_j_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.j" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_offset : coverpoint get_imm(ins.ops[0].key, "C-J") {
        option.comment = "Branch Immediate Offset value";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup

covergroup c_jal_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.jal" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_offset : coverpoint get_imm(ins.ops[0].key, "C-JAL") {
        option.comment = "Branch Immediate Offset value";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup

covergroup c_jalr_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.jalr" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rs1 : coverpoint get_gpr_reg(ins.ops[0].key, "C-JALR") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
    cp_rs1_sign : coverpoint int'(ins.ops[0].val) {
        option.comment = "RS1 (GPR) sign of value";
        bins neg  = {[$:-1]};
        bins pos  = {[1:$]};
    }
    
endgroup

covergroup c_jr_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.jr" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rs1 : coverpoint get_gpr_reg(ins.ops[0].key, "C-JR") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
endgroup

covergroup c_lw_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.lw" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rdp : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-LW") {
        option.comment = "RD (GPR) register assignment";
    }
    
    cp_rs1p : coverpoint get_gpr_c_reg(ins.ops[1].key, "C-LW") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
endgroup

covergroup c_lwsp_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.lwsp" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "C-LWSP") {
        option.comment = "RD (GPR) register assignment";
    }
    
endgroup

covergroup c_slli_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.slli" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rd : coverpoint get_gpr_reg(ins.ops[0].key, "C-SLLI") {
        option.comment = "RD (GPR) register assignment";
    }
    
endgroup

covergroup c_srai_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.srai" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rdp : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-SRAI") {
        option.comment = "RD (GPR) register assignment";
    }
    
endgroup

covergroup c_srli_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.srli" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rdp : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-SRLI") {
        option.comment = "RD (GPR) register assignment";
    }
    
endgroup

covergroup c_sw_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.sw" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rs1p : coverpoint get_gpr_c_reg(ins.ops[2].key, "C-SW") {
        option.comment = "RS1 (GPR) register assignment";
    }
    
    cp_rs2p : coverpoint get_gpr_c_reg(ins.ops[0].key, "C-SW") {
        option.comment = "RS2 (GPR) register assignment";
    }
    
endgroup

covergroup c_swsp_cg with function sample(ins_rv32zca_t ins);
    option.per_instance = 1; 

    cp_asm_count : coverpoint ins.ins_str == "c.swsp" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_rs2 : coverpoint get_gpr_reg(ins.ops[0].key, "C-SWSP") {
        option.comment = "RS2 (GPR) register assignment";
    }
    
endgroup


function ins_rv32zca_t get_rv32zca_inst(bit trap, int hart, int issue, string disass); // break and move this first bit out
    string insbin, ins_str, op[4], key, val;
    ins_rv32zca_t ins;
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
        end else begin
            ins.ops[i].val = ins.ops[i].key;
        end       
    end
    return ins;
endfunction

function void rv32zca_sample(string inst_name, bit trap, int hart, int issue, string disass);
    case (inst_name)
        "c.add"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_add_cg.sample(ins); end
        "c.mv"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_mv_cg.sample(ins); end
        "c.addi"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_addi_cg.sample(ins); end
        "c.addi16sp"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_addi16sp_cg.sample(ins); end
        "c.addi4spn"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_addi4spn_cg.sample(ins); end
        "c.li"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_li_cg.sample(ins); end
        "c.lui"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_lui_cg.sample(ins); end
        "c.and"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_and_cg.sample(ins); end
        "c.or"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_or_cg.sample(ins); end
        "c.sub"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_sub_cg.sample(ins); end
        "c.xor"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_xor_cg.sample(ins); end
        "c.andi"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_andi_cg.sample(ins); end
        "c.beqz"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_beqz_cg.sample(ins); end
        "c.bnez"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_bnez_cg.sample(ins); end
        "c.j"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_j_cg.sample(ins); end
        "c.jal"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_jal_cg.sample(ins); end
        "c.jalr"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_jalr_cg.sample(ins); end
        "c.jr"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_jr_cg.sample(ins); end
        "c.lw"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_lw_cg.sample(ins); end
        "c.lwsp"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_lwsp_cg.sample(ins); end
        "c.slli"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_slli_cg.sample(ins); end
        "c.srai"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_srai_cg.sample(ins); end
        "c.srli"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_srli_cg.sample(ins); end
        "c.sw"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_sw_cg.sample(ins); end
        "c.swsp"     : begin ins_rv32zca_t ins = get_rv32zca_inst(trap, hart, issue, disass); c_swsp_cg.sample(ins); end
    endcase
endfunction

