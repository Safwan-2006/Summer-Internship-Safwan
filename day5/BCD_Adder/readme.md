
# 4-Bit BCD (Binary-Coded Decimal) Adder in SystemVerilog

## 📌 Project Overview
This repository contains the RTL design and verification environment for a 1-digit (4-bit) BCD Adder. The design performs addition on two 4-bit binary-coded decimal numbers. If the initial sum exceeds 9 (or generates a carry-out), the circuit automatically detects the invalid BCD state and adds a correction factor of `0110` (decimal 6) using a second stage to produce the correct BCD sum and carry-out. 

The design utilizes a structural modeling approach, building the main BCD adder from lower-level 4-bit Ripple Carry Adders (RCA), which are in turn built from 1-bit full adder primitive gates.

## 📁 File Structure
* **`bcd_adder.sv`**: The top-level module implementing the BCD addition and correction logic.
* **`RIPPLE_CARRY_ADDER`**: A sub-module consisting of a 4-bit cascaded adder.
* **`fulladder`**: A 1-bit full adder sub-module using gate-level primitives (`xor`, `and`, `or`).
* **`bcd_adder_if`**: A SystemVerilog interface used to cleanly bundle the inputs and outputs for the testbench.
* **`bcd_adder_tb.sv`**: The testbench that instantiates the interface and verifies the design using directed test vectors.

## 🛠️ Tools Used
* **Hardware Description Language:** Verilog / SystemVerilog
* **Simulation & Synthesis:** Xilinx Vivado (or any standard SV-compatible simulator like ModelSim/Questa)

## 📊 Expected Simulation Results
The `bcd_adder_tb` applies a sequence of test vectors with a 50ns delay between each. Below are the theoretical outputs based on the applied stimuli. *Note: When the sum exceeds 9, the BCD output represents the units digit, and the `cout` represents the tens digit.*

| Time (ns) | `a` (Operand A) | `b` (Operand B) | `c` (Carry In) | Expected `sum` (BCD Result) | Expected `cout` | Decimal Equivalent |
| :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **0** | `0000` | `0000` | `0` | `0000` | `0` | 0 + 0 = 0 |
| **50** | `0010` | `0011` | `0` | `0101` | `0` | 2 + 3 = 5 |
| **100** | `0101` | `0100` | `0` | `1001` | `0` | 5 + 4 = 9 |
| **150** | `0110` | `0111` | `0` | `0011` | `1` | 6 + 7 = 13 (Outputs BCD `3` with Carry `1`) |
| **200** | `1000` | `1000` | `0` | `0110` | `1` | 8 + 8 = 16 (Outputs BCD `6` with Carry `1`) |

## 📈 Simulation Waveform
<img width="1549" height="701" alt="bcd_interfacing" src="https://github.com/user-attachments/assets/70eb1915-5e0f-44a7-b941-403da9faa682" />

---
**Author:** Mohammed Safwan M.
