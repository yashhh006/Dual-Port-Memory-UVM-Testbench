`define width 8
`define depth 32
`define addr_width $clog2(`depth)

`define new_obj\
function new(string name="");\
  super.new(name);\
endfunction\

`define new_comp\
function new(string name="", uvm_component parent);\
  super.new(name,parent);\
endfunction\
