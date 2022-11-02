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
} ins_rv32zcmp_t;


covergroup cm_push_cg with function sample(ins_rv32zcmp_t ins);
    option.per_instance = 1; 
    option.comment = "Create Stack Frame";

    cp_asm_count : coverpoint ins.ins_str == "cm.push" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_sreg_list : coverpoint get_sreg_list(ins.ops[0].key, "CM-PUSH") {
        option.comment = "Stack register List";
    }
    
    cp_stack_adj : coverpoint get_spimm(ins.ops[1].key, "CM-PUSH") {
        option.comment = "Stack adjust value";
        bins stack_adj[]  = {16,32,48,64,80,96,112};
    }
    
endgroup

covergroup cm_pop_cg with function sample(ins_rv32zcmp_t ins);
    option.per_instance = 1; 
    option.comment = "Destroy Stack Frame";

    cp_asm_count : coverpoint ins.ins_str == "cm.pop" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_sreg_list : coverpoint get_sreg_list(ins.ops[0].key, "CM-POP") {
        option.comment = "Stack register List";
    }
    
    cp_stack_adj : coverpoint get_spimm(ins.ops[1].key, "CM-POP") {
        option.comment = "Stack adjust value";
        bins stack_adj[]  = {16,32,48,64,80,96,112};
    }
    
endgroup

covergroup cm_popretz_cg with function sample(ins_rv32zcmp_t ins);
    option.per_instance = 1; 
    option.comment = "Destroy Stack Frame, move zero into a0, return to ra";

    cp_asm_count : coverpoint ins.ins_str == "cm.popretz" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_sreg_list : coverpoint get_sreg_list(ins.ops[0].key, "CM-POPRETZ") {
        option.comment = "Stack register List";
    }
    
    cp_stack_adj : coverpoint get_spimm(ins.ops[1].key, "CM-POPRETZ") {
        option.comment = "Stack adjust value";
        bins stack_adj[]  = {16,32,48,64,80,96,112};
    }
    
endgroup

covergroup cm_popret_cg with function sample(ins_rv32zcmp_t ins);
    option.per_instance = 1; 
    option.comment = "Destroy Stack Frame, return to ra";

    cp_asm_count : coverpoint ins.ins_str == "cm.popret" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_sreg_list : coverpoint get_sreg_list(ins.ops[0].key, "CM-POPRET") {
        option.comment = "Stack register List";
    }
    
    cp_stack_adj : coverpoint get_spimm(ins.ops[1].key, "CM-POPRET") {
        option.comment = "Stack adjust value";
        bins stack_adj[]  = {16,32,48,64,80,96,112};
    }
    
endgroup

covergroup cm_mvsa01_cg with function sample(ins_rv32zcmp_t ins);
    option.per_instance = 1; 
    option.comment = "Move a0-a1 into two registers of s0-s7";

    cp_asm_count : coverpoint ins.ins_str == "cm.mvsa01" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_sreg1 : coverpoint get_stack_reg(ins.ops[0].key, "CM-MVSA01") {
        option.comment = "Stack register assignment";
    }
    
    cp_sreg2 : coverpoint get_stack_reg(ins.ops[1].key, "CM-MVSA01") {
        option.comment = "Stack register assignment";
    }
    
endgroup

covergroup cm_mva01s_cg with function sample(ins_rv32zcmp_t ins);
    option.per_instance = 1; 
    option.comment = "Move two s0-s7 registers into a0-a1";

    cp_asm_count : coverpoint ins.ins_str == "cm.mva01s" {
        option.comment = "Number of times instruction is executed";
        bins count[]  = {1};
    }
    
    cp_sreg1 : coverpoint get_stack_reg(ins.ops[0].key, "CM-MVA01S") {
        option.comment = "Stack register assignment";
    }
    
    cp_sreg2 : coverpoint get_stack_reg(ins.ops[1].key, "CM-MVA01S") {
        option.comment = "Stack register assignment";
    }
    
endgroup


function ins_rv32zcmp_t get_rv32zcmp_inst(bit trap, int hart, int issue, string disass); // break and move this first bit out
    string insbin, ins_str, op[4], key, val;
    ins_rv32zcmp_t ins;
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

    // Check if reg list and combine full list into single operand
    if (op[0] == "{") begin
        for (i = 0; i < op[1].len(); i++) begin
            if (op[1][i] == "}") begin
                op[0] = {op[0],",",op[1]};
                op[1] = op[2];
                num = 4;
            end
        end
    end
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

function void rv32zcmp_sample(string inst_name, bit trap, int hart, int issue, string disass);
    case (inst_name)
        "cm.push"     : begin ins_rv32zcmp_t ins = get_rv32zcmp_inst(trap, hart, issue, disass); cm_push_cg.sample(ins); end
        "cm.pop"     : begin ins_rv32zcmp_t ins = get_rv32zcmp_inst(trap, hart, issue, disass); cm_pop_cg.sample(ins); end
        "cm.popretz"     : begin ins_rv32zcmp_t ins = get_rv32zcmp_inst(trap, hart, issue, disass); cm_popretz_cg.sample(ins); end
        "cm.popret"     : begin ins_rv32zcmp_t ins = get_rv32zcmp_inst(trap, hart, issue, disass); cm_popret_cg.sample(ins); end
        "cm.mvsa01"     : begin ins_rv32zcmp_t ins = get_rv32zcmp_inst(trap, hart, issue, disass); cm_mvsa01_cg.sample(ins); end
        "cm.mva01s"     : begin ins_rv32zcmp_t ins = get_rv32zcmp_inst(trap, hart, issue, disass); cm_mva01s_cg.sample(ins); end
    endcase
endfunction


