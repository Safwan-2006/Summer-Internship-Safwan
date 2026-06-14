# 8-Bit Synchronous FIFO in SystemVerilog/Verilog

## 📌 Project Overview
This repository contains the RTL design and verification environment for an 8-bit wide, depth-8 Synchronous FIFO (First-In-First-Out) memory buffer. The design includes a circular buffer mechanism with automated pointer management, providing `full` and `empty` status flags to prevent data loss. The verification environment utilizes a SystemVerilog `interface` for clean signal bundling and testbench connection.

## 📁 File Structure
* **`fifo.sv`**: The top-level module implementing the synchronous FIFO logic, memory array, and flag generation.
* **`fifo_tb.sv`**: The testbench for verifying the FIFO functionality, applying directed stimuli including burst writes and reads.

## 🛠️ Tools Used
* **Hardware Description Language:** Verilog / SystemVerilog
* **Simulation & Synthesis:** Xilinx Vivado (or any standard SV-compatible simulator like ModelSim/Questa)

## 📊 Expected Simulation Results
The `fifo_tb` applies a sequence of resets, writes, and reads based on a 10ns clock period (`#5` half-period). Below are the expected theoretical outputs based on the applied stimuli phases:

| Time / Phase | `wrenb` | `rdenb` | `data_in` (Hex) | Expected `data_out` (Hex) | `empty` | `full` | Description |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **0 - 20 ns** | `0` | `0` | `00` | `00` | `1` | `0` | **System Reset:** Pointers cleared, memory initialized to 0. |
| **20 - 50 ns** | `1` | `0` | `AA`, `BB`, `CC` | `00` | `0` | `0` | **Sequential Writes:** Three values written. `empty` goes low. |
| **50 - 70 ns** | `0` | `0` | `CC` (held) | `00` | `0` | `0` | **Idle State:** Pointers hold their current values. |
| **70 - 90 ns** | `0` | `1` | `--` | `AA`, `BB` | `0` | `0` | **Sequential Reads:** First two values popped out of the FIFO. |
| **110 - 180 ns** | `1` | `0` | `01` to `07` | `BB` (held) | `0` | `1` (at end) | **Burst Write:** Filling the FIFO. `full` flag asserts when full. |
| **200 - 280 ns** | `0` | `1` | `--` | `CC`, `01`... | `1` (at end) | `0` | **Burst Read:** Emptying the FIFO. `empty` flag asserts at the end. |

## 📈 Simulation Waveform
<img width="1554" height="690" alt="fifo_interfacing" src="https://github.com/user-attachments/assets/48906757-39a8-4faf-ad93-435dc76133ee" />


---
**Author:** Mohammed Safwan M.
