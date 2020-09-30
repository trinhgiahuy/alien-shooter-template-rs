# Alien shooter, Rust version

This branch has been edited to run on TC219 machines in particular. See `standalone` branch for a version that runs on an unknown system configuration.

## Setup

1. Install Rust:
    - Go to [rustup.rs](https://rustup.rs/) and follow the instructions.
2. Install the nightly toolchain:
    - ```rustup install nightly```.
    - We need the nightly toolchain to compile a line of assembly to enable interrupts via a `libxil` C-FFI library.
3. Install the cross-compiler:
    * `rustup target add armv7a-none-eabi`.

## Build and run
- Build the binary:
    * `XILINX_SDK="C:/Apps/Xilinx_Vivado2017/SDK/2017.2" cargo build`.
    * Consecutive builds from the same terminal can just use `cargo build` without re-setting the environment variable.
- Run the binary on a connected PYNQ-Z1:
    * Open a Xilinx Command Line Tools -prompt.
    * Navigate to the project directory.
    * Run `source run_on_pynq.tcl` to initialize and run the built program on a connected PYNQ.

## Directory structure and files

| Path            | Description                                                                                                    |
|-----------------|----------------------------------------------------------------------------------------------------------------|
| .cargo/config   | A file describing the location and options of the C-linker.                                                    |
| Cargo.toml      | A Rust manifest describing dependencies.                                                                       |
| Cargo.lock      | A generated file describing the last successful build configuration. Commit along with changes to dependencies |
| pynq/           | Extra files required to cross-compile on PYNQ-Z1 and program the FPGA.                                         |
| run_on_pynq.tcl | A tickle-script to initialize the FPGA and run the project on Pynq                                             |
| rust-toolchain  | A file to ask rustup to use a particular toolchain                                                             |
| src/            | The Rust source code                                                                                           |


## Troubleshooting
- `cargo build` fails with can't find crate for `core`.
    * Did you add the component for the cross-compiler with ```rustup target add armv7a-none-eabi```?
- `cargo build` fails with "warning: couldn't execute `llvm-config --prefix`".
    * Likely cause: cargo cannot detect the LLVM toolchain, LLVM needs to be installed.
- `cargo build` fails with "cannot detect Xilinx SDK at C:/Xilinx".
    * The libxil FFI dependency cannot locate the Xilinx toolchain automatically. Make sure that Xilinx SDK is installed and set its path using `export XILINX_SDK=/path/to/Xilinx/SDK/version`.
- `cargo build` fails with "error: linker `arm-none-eabi-gcc` not found".
    * The appropriate linker is not found. Use .cargo/config to point cargo to a functioning linker using the key "linker = /location/linker-executable".
- `cargo build` fails with "error: linker `C:/.../arm-none-eabi-gcc` not found".
    * The GCC linker used for this work is not available at its pre-configured location at .cargo/config.
- `source run_on_pynq.tcl` returns "no targets found with ...".
    * Make sure the PYNQ-Z1 is turned on and connected.

