# 4-Bit Ripple Carry Adder (RCA) in Verilog

## 📌 Project Overview
This repository contains the Verilog RTL design and verification environment for a 4-bit Ripple Carry Adder. The design uses structural modeling by cascading four 1-bit Full Adder modules to perform binary addition on two 4-bit operands along with an initial carry-in.

## 📁 File Structure
* **`RIPPLE_CARRY_ADDER.v`**: The top-level module implementing the 4-bit RCA.
* **`fulladder.v`**: The 1-bit full adder sub-module using gate-level primitives (`xor`, `and`, `or`).
* **`RIPPLE_CARRY_ADDER_tb.v`**: The testbench for verifying the 4-bit RCA top module.
* **`fulladder_tb.v`**: The testbench for verifying the standalone 1-bit full adder.

## 🛠️ Tools Used
* **Hardware Description Language:** Verilog
* **Simulation & Synthesis:** Xilinx Vivado

## 📊 Expected Simulation Results
The `RIPPLE_CARRY_ADDER_tb` applies a sequence of test vectors with a 100ns delay between each. Below are the expected theoretical outputs for the `$monitor` console based on the applied stimuli:

| Time (ns) | `a_tb` (Operand A) | `b_tb` (Operand B) | `cin_tb` (Carry In) | Expected `sum_tb` | Expected `cout_tb` | Decimal Equivalent (A + B + Cin) |
| :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| 0 | `0000` | `0000` | `0` | `0000` | `0` | 0 + 0 + 0 = 0 |
| 100 | `0010` | `0011` | `0` | `0101` | `0` | 2 + 3 + 0 = 5 |
| 200 | `0101` | `0101` | `1` | `1011` | `0` | 5 + 5 + 1 = 11 |
| 300 | `1000` | `1000` | `0` | `0000` | `1` | 8 + 8 + 0 = 16 (Sum=0, Carry=1) |
| 400 | `1111` | `1111` | `1` | `1111` | `1` | 15 + 15 + 1 = 31 (Sum=15, Carry=1)|

## 📈 Simulation Waveform
*(Upload your simulation result image to your repository and replace the placeholder link below)*

![Simulation Waveform](link_to_your_simulation_result_image.png)
> **Note:** The above waveform demonstrates the successful verification of the Ripple Carry Adder. The propagation delays and logical transitions match the expected truth table values.

## 🚀 How to Run
1. Create a new RTL project in your simulation tool (e.g., Vivado).
2. Add `RIPPLE_CARRY_ADDER.v` and `fulladder.v` as design sources.
3. Add `RIPPLE_CARRY_ADDER_tb.v` and `fulladder_tb.v` as simulation sources.
4. Set `RIPPLE_CARRY_ADDER_tb` as the top module for simulation.
5. Run the behavioral simulation and observe the TCL console for `$monitor` outputs and the waveform viewer for timing diagrams.

---
**Author:** Mohammed Safwan M.
