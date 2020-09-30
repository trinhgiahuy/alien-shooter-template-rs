# Auto-connect to something, probably the PYNQ
connect

# Set a core as target; we choose something that starts with "ARM" and ends with "#0"
targets -set -filter {name =~ "ARM*#0"}

# Reset the targeted core
rst

# Push the "hardware implementation" with eg. LED drivers onto the FPGA
fpga pynq/top.bit

# Load the hardware description to help debugger understand what's going on
loadhw pynq/system.hdf

# Load a script that sets up specific memory areas
source pynq/ps7_init.tcl

# Run a couple of magic functions to define memory areas
ps7_init
ps7_post_config

# Download our binary onto the target core
dow target/armv7a-none-eabi/debug/alien-shooter-rs

# Resume the core that's now executing our app
con
