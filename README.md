# Nano_Processor_Team_49

# Nano Processor

A small 4-bit nano processor implemented in VHDL for the Digilent Basys 3 FPGA board. The design includes a program counter, instruction decoder, register bank, ALU, program ROM, 7-segment display output, status flags, and simulation testbenches.

## Project Overview

This processor executes 12-bit instructions stored in `Program_ROM.vhd`. It uses eight 4-bit registers (`R0` to `R7`) and displays the main output through LEDs and the Basys 3 seven-segment display.

The current ROM program calculates:

```text
1 + 2 + 3 = 6
```

The final result is accumulated in `R7`, which is connected to the LED output and seven-segment display.

## Main Features

- 4-bit datapath
- 8 general-purpose 4-bit registers
- 3-bit program counter
- 8-instruction program ROM
- 12-bit instruction format
- Addition and subtraction/negation support
- Immediate value loading using `MOVI`
- Conditional jump using `JZR`
- Carry, zero, and overflow flags
- Basys 3 FPGA pin constraints
- Separate testbenches for major components

## Repository Structure

Nano_Processor/
├── README.md
├── Instruction.txt
├── Nano_Processor/
│   ├── sources_1/
│   │   ├── NanoProcessor.vhd
│   │   ├── OurProcessor.vhd
│   │   ├── Program_ROM.vhd
│   │   ├── Instruction_Decoder.vhd
│   │   ├── Register_Bank.vhd
│   │   ├── Add_Sub.vhd
│   │   ├── PC.vhd
│   │   ├── Slow_Clk.vhd
│   │   └── supporting mux, decoder, adder, and register modules
│   ├── sim_1/
│   │   └── VHDL testbenches
│   └── constrs_1/
│       └── Basys3Labs.xdc
├── sources_1/
│   └── imported/extra source files
└── sim_1/
    └── imported/extra simulation files

## Top-Level Module

The main hardware top-level module is:
  Nano_Processor/sources_1/NanoProcessor.vhd

Top-level ports:

| Port | Direction | Description |
|---|---:|---|
| `Clk` | Input | Basys 3 onboard clock |
| `Reset` | Input | Resets program counter and registers |
| `Reg[3:0]` | Output | Current `R7` register value shown on LEDs |
| `Zero` | Output | ALU zero flag |
| `Overflow` | Output | ALU overflow flag |
| `Carry` | Output | ALU carry flag |
| `Display[6:0]` | Output | Seven-segment display segments |
| `Anode[3:0]` | Output | Seven-segment display anode control |

## Instruction Format

Each instruction is 12 bits:

I(11 downto 10) : Opcode
I(9 downto 7)   : RegA
I(6 downto 4)   : RegB
I(3 downto 0)   : Immediate value
I(2 downto 0)   : Jump address for JZR

## Instruction Set

| Opcode | Instruction | Operation |
|---|---|---|
| `00` | `ADD` | `RegA <- RegA + RegB` |
| `01` | `SUB/NEG` | Uses ALU subtraction mode |
| `10` | `MOVI` | `RegA <- Immediate` |
| `11` | `JZR` | Jump to address if selected register is zero |

Register encoding:

| Register | Code |
|---|---|
| `R0` | `000` |
| `R1` | `001` |
| `R2` | `010` |
| `R3` | `011` |
| `R4` | `100` |
| `R5` | `101` |
| `R6` | `110` |
| `R7` | `111` |

## Current ROM Program

The active program is defined in:
  Nano_Processor/sources_1/Program_ROM.vhd

Current instructions:
"100010000001", -- 0: Movi R1, 1
"100100000010", -- 1: Movi R2, 2
"001110010000", -- 2: Add  R7, R1
"001110100000", -- 3: Add  R7, R2
"100110000011", -- 4: Movi R3, 3
"001110110000", -- 5: Add  R7, R3
"100010000000", -- 6: Movi R1, 0
"110000000111"  -- 7: JZR  R0, 7

Expected final value:
  R7 = 0110

## Basys 3 I/O Mapping

The pin mapping is defined in:
  Nano_Processor/constrs_1/Basys3Labs.xdc

Main board connections:

| Signal | Basys 3 Pin |
|---|---|
| `Clk` | `W5` |
| `Reset` | `U18` |
| `Reg[0]` | `U16` |
| `Reg[1]` | `E19` |
| `Reg[2]` | `U19` |
| `Reg[3]` | `V19` |
| `Overflow` | `N3` |
| `Zero` | `P1` |
| `Carry` | `L1` |

The seven-segment display uses `Display[6:0]` and `Anode[3:0]`.

## How to Run in Vivado

1. Open Xilinx Vivado.
2. Create a new RTL project.
3. Add the VHDL files from:
   Nano_Processor/sources_1/
4. Add simulation files from:
   Nano_Processor/sim_1/
5. Add the Basys 3 constraint file:
   Nano_Processor/constrs_1/Basys3Labs.xdc
6. Set `NanoProcessor.vhd` as the top module.
7. Run synthesis, implementation, and bitstream generation.
8. Program the Basys 3 board.

## Simulation

Use the files in `Nano_Processor/sim_1/` to test individual components and the full processor.

Important testbenches:

| Testbench | Purpose |
|---|---|
| `TB_NanoProcessor.vhd` | Full processor simulation |
| `TB_Add_Sub.vhd` | ALU add/sub simulation |
| `TB_Register_Bank.vhd` | Register bank simulation |
| `TB_PC.vhd` | Program counter simulation |
| `Program_ROM_TB.vhd` | Program ROM simulation |
| `TB_Mux_8_to_1_4bit.vhd` | 8-to-1 mux simulation |

## Editing the Program

To change the program, edit the ROM contents in:
  Nano_Processor/sources_1/Program_ROM.vhd

Each ROM entry must be a 12-bit binary instruction. The ROM has 8 instruction locations because the program counter is 3 bits wide.

## Notes
- `R7` is used as the main visible output register.
- `Anode` is currently fixed to `"1110"`, so one seven-segment digit is enabled.
- `Slow_Clk.vhd` divides the Basys 3 clock so the processor can be observed more easily on hardware.
- Some duplicate/imported source files exist under the root `sources_1/` and `sim_1/` folders. The main organized project files are inside `Nano_Processor/sources_1/`, `Nano_Processor/sim_1/`, and `Nano_Processor/constrs_1/`.

## Requirements

- Xilinx Vivado
- Digilent Basys 3 FPGA board
- VHDL simulation support through Vivado Simulator or another compatible simulator
