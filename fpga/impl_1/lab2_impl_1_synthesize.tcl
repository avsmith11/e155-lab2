if {[catch {

# define run engine funtion
source [file join {C:/lscc/radiant/2024.1} scripts tcl flow run_engine.tcl]
# define global variables
global para
set para(gui_mode) "1"
set para(prj_dir) "C:/Users/oaksh/Desktop/E155/lab2/fpga"
# synthesize IPs
# synthesize VMs
# synthesize top design
file delete -force -- lab2_impl_1.vm lab2_impl_1.ldc
::radiant::runengine::run_engine_newmsg synthesis -f "lab2_impl_1_lattice.synproj" -logfile "lab2_impl_1_lattice.srp"
::radiant::runengine::run_postsyn [list -a iCE40UP -p iCE40UP5K -t SG48 -sp High-Performance_1.2V -oc Industrial -top -w -o lab2_impl_1_syn.udb lab2_impl_1.vm] [list C:/Users/oaksh/Desktop/E155/lab2/fpga/impl_1/lab2_impl_1.ldc]

} out]} {
   ::radiant::runengine::runtime_log $out
   exit 1
}
