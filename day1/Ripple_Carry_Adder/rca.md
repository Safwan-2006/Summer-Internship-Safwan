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

<img width="1552" height="690" alt="ripplecarryadder" src="https://github.com/user-attachments/assets/eaec8c3f-06ae-4f2b-8b5d-d465330b3215" />

---
**Author:** Mohammed Safwan M.
