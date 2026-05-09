# Nano Processor - Team 49

A 4-bit nano processor implemented in VHDL for FPGA implementation and simulation. The processor uses a 12-bit instruction format, a 3-bit program counter, an 8-register bank, arithmetic logic, program ROM, status flags, and seven-segment display output.

## Project Overview

The main implementation is organized inside the `components/` directory. The current ROM program calculates:

```text
1 + 2 + 3 = 6
```

The result is accumulated in register `R7`. The top-level module connects `R7` to the `Reg` output and also sends it to the seven-segment display lookup component.

The repository also includes an imported/advanced Vivado source set under `Nano_Processor_advanced/`.

## Features

- 4-bit datapath
- 8 general-purpose registers: `R0` to `R7`
- 3-bit program counter
- 8-instruction program ROM
- 12-bit instruction format
- ADD, SUB/NEG, MOVI, and JZR instruction support in the current main datapath
- Carry, zero, and overflow flag outputs
- Slow clock divider for FPGA observation
- Seven-segment display output
- VHDL testbenches for selected modules

## Repository Structure

```text
Nano_Processor_Team_49/
|-- README.md
|-- Instruction.txt
|-- components/
|   |-- Nanoprocessor.vhd
|   |-- 3-bit-adder/
|   |-- 4-bit-adder-subtractor/
|   |-- arithmetic-unit/
|   |-- Decoder/
|   |-- flip-flop/
|   |-- instruction_decoder/
|   |-- load-selector/
|   |-- mux/
|   |-- operand-selector/
|   |-- pc-incremeter/
|   |-- program-counter/
|   |-- program-rom/
|   |-- registers/
|   `-- Slow_Clk/
|-- tests/
|   |-- TB_AS.vhd
|   |-- TB_Add_Sub.vhd
|   |-- TB_Adder_3_Bit.vhd
|   `-- TB_Adder_3bit.vhd
|-- Design/
`-- Nano_Processor_advanced/
    |-- srcs_1/
    |-- sim_1/
    `-- constrn_1/
```

## Main Top-Level Module

Top-level file:

```text
components/Nanoprocessor.vhd
```

Top-level entity:

```vhdl
entity NanoProcessor is
    Port (
        Clk      : in  STD_LOGIC;
        Reset    : in  STD_LOGIC;
        Reg      : out STD_LOGIC_VECTOR (3 downto 0);
        Zero     : out STD_LOGIC;
        Overflow : out STD_LOGIC;
        Display  : out STD_LOGIC_VECTOR (6 downto 0);
        Anode    : out STD_LOGIC_VECTOR (3 downto 0);
        Carry    : out STD_LOGIC
    );
end NanoProcessor;
```

### Main Outputs

| Signal | Description |
|---|---|
| `Reg[3:0]` | Current value of `R7` |
| `Zero` | Zero flag from the adder/subtractor |
| `Overflow` | Overflow flag |
| `Carry` | Carry output |
| `Display[6:0]` | Seven-segment display segment output |
| `Anode[3:0]` | Seven-segment anode control, fixed to `"1110"` |

## Instruction Format

Each instruction is 12 bits wide:

```text
I(11 downto 10) = Opcode
I(9 downto 7)   = RegA
I(6 downto 4)   = RegB
I(3 downto 0)   = Immediate value
I(2 downto 0)   = Jump address for JZR
```

## Instruction Set

| Opcode | Instruction | Operation |
|---|---|---|
| `00` | `ADD` | `RegA <- RegA + RegB` |
| `01` | `SUB/NEG` | Subtraction/negation through the adder-subtractor |
| `10` | `MOVI` | `RegA <- Immediate` |
| `11` | `JZR` | Jump to address if the selected register value is zero |

`Instruction.txt` also documents planned/special encodings for absolute difference and multiplication:

| Encoding | Planned Operation |
|---|---|
| Opcode `00`, immediate `1111` | Absolute difference |
| Opcode `00`, immediate `1110` | Multiplication |

## Register Encoding

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

The active main ROM is in:

```text
components/program-rom/Program_Rom.vhd
```

Current ROM contents:

```vhdl
"100010000001", -- 0: Movi R1, 1
"100100000010", -- 1: Movi R2, 2
"001110010000", -- 2: Add  R7, R1
"001110100000", -- 3: Add  R7, R2
"100110000011", -- 4: Movi R3, 3
"001110110000", -- 5: Add  R7, R3
"100010000000", -- 6: Movi R1, 0
"110000000111"  -- 7: JZR  R0, 7
```

Expected final result:

```text
R7 = 0110
Decimal value = 6
```

## Main Components

| Component | File |
|---|---|
| Top-level processor | `components/Nanoprocessor.vhd` |
| Program ROM | `components/program-rom/Program_Rom.vhd` |
| Instruction decoder | `components/instruction_decoder/Instruction_Decoder.vhd` |
| Register bank | `components/registers/Register_Bank.vhd` |
| Program counter | `components/program-counter/PC.vhd` |
| 3-bit adder | `components/3-bit-adder/Adder_3bit.vhd` |
| 4-bit adder/subtractor | `components/4-bit-adder-subtractor/Add_Sub.vhd` |
| Slow clock divider | `components/Slow_Clk/Slow_Clk.vhd` |
| Multiplexers | `components/mux/` |
| Decoder | `components/Decoder/` |

## Advanced Source Set

The `Nano_Processor_advanced/` directory contains a separate imported Vivado-style source set:

| Directory | Purpose |
|---|---|
| `Nano_Processor_advanced/srcs_1/` | Advanced/imported VHDL source files |
| `Nano_Processor_advanced/sim_1/` | Advanced/imported simulation testbenches |
| `Nano_Processor_advanced/constrn_1/` | Basys 3 constraint file |

Important advanced files include `PC.vhd`, `Program_ROM.vhd`, `Register_Bank.vhd`, `Comparator.vhd`, `multiplier_4.vhd`, and `Basys3Labs.xdc`.

Before using the advanced source set in Vivado, confirm that each file name matches the entity inside the file.

## How to Run in Vivado

1. Open Xilinx Vivado.
2. Create a new RTL project.
3. Add all VHDL source files from `components/`.
4. Add simulation files from `tests/` if simulation is required.
5. Set `NanoProcessor` from `components/Nanoprocessor.vhd` as the top module.
6. Add a Basys 3 constraint file if programming the board.
7. Run synthesis and implementation.
8. Generate the bitstream.
9. Program the FPGA board.

For the advanced/imported design, add files from `Nano_Processor_advanced/srcs_1/`, simulation files from `Nano_Processor_advanced/sim_1/`, and constraints from `Nano_Processor_advanced/constrn_1/`.

## Simulation

Main testbenches are available in the `tests/` directory.

| Testbench | Purpose |
|---|---|
| `TB_Add_Sub.vhd` | Tests the 4-bit adder/subtractor |
| `TB_AS.vhd` | Additional adder/subtractor testbench |
| `TB_Adder_3bit.vhd` | Tests the 3-bit adder |
| `TB_Adder_3_Bit.vhd` | Additional 3-bit adder testbench |

Additional advanced testbenches are available in:

```text
Nano_Processor_advanced/sim_1/
```

## Editing the Program

To change the main processor program, edit the ROM array in:

```text
components/program-rom/Program_Rom.vhd
```

Each ROM entry must be a 12-bit binary instruction. The ROM currently has 8 instruction locations because the program counter is 3 bits wide.

## Notes

- `R7` is used as the main visible output register.
- The program counter uses 3 bits, so the processor can address 8 ROM locations.
- `Slow_Clk.vhd` divides the input clock so the processor state can be observed more easily on hardware.
- `Anode` is fixed to `"1110"`, enabling one seven-segment digit.
- Check the selected Basys 3 constraint file before FPGA programming to confirm that the board pin mappings match the hardware.

## Requirements

- Xilinx Vivado
- VHDL simulator such as Vivado Simulator
- FPGA board such as Digilent Basys 3, if hardware testing is required
