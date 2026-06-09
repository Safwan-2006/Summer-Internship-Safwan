# 4-Bit Universal Shift Register in Verilog

## 📌 Project Overview
This repository contains the Verilog RTL design and verification environment for a 4-Bit Universal Shift Register. The design is capable of performing bidirectional data movement and parallel loading based on mode selection lines. It supports all four standard shift register operations: Serial-In Serial-Out (SISO), Serial-In Parallel-Out (SIPO), Parallel-In Serial-Out (PISO), and Parallel-In Parallel-Out (PIPO). 

## 📁 File Structure
* **`Universal_SR.v`**: The top-level module implementing the Universal Shift Register logic with synchronous reset and mode control.
* **`Universal_SR_tb.v`**: The testbench for verifying all operational modes of the shift register using sequential test stimuli.

## 🛠️ Tools Used
* **Hardware Description Language:** Verilog
* **Simulation & Synthesis:** Xilinx Vivado

## 📊 Expected Simulation Results
The `Universal_SR_tb` applies a sequence of operations to test the various modes of the shift register. Below are the expected behavioral results based on the applied stimuli in the testbench:

| Operation Phase | Mode (`mod_tb`) | Control Signals | Input Data Applied | Expected Output |
| :--- | :---: | :---: | :--- | :--- |
| **Initialization** | `X` | `rst_tb = 1` | `X` | Internal `temp` clears to `0000`. |
| **SISO** <br>*(Serial In Serial Out)* | `00` | `shift_tb = 1`<br>`load_tb = 1` | `sin_tb` sequence: `1, 0, 1, 1` | Data shifts right. `sout_tb` outputs the LSB sequentially. `pout_tb` remains `0000`. |
| **SIPO** <br>*(Serial In Parallel Out)* | `01` | `shift_tb = 1`<br>`load_tb = 1` | `sin_tb` sequence: `0, 1, 0, 1` | Data shifts right. `pout_tb` updates continuously to show the 4-bit shifted state. |
| **PISO / Parallel Load** | `10` | `shift_tb = 0`<br>`load_tb = 1` | `pin_tb = 1010` | The internal register loads `1010`. `sout_tb` outputs the LSB (`0`). |
| **PIPO** <br>*(Parallel In Parallel Out)* | `11` | `shift_tb = 0`<br>`load_tb = 1` | `pin_tb` sequence:<br>`1100`, `0110`, `1001`, `1111` | `pout_tb` instantly reflects the loaded parallel input values (c, 6, 9, f). |
| **Output Disable** | `X` | `load_tb = 0` | `X` | `sout_tb` goes to `0`, `pout_tb` resets to `0000` regardless of internal state. |

## 📈 Simulation Waveform
<img width="1547" height="669" alt="usr" src="https://github.com/user-attachments/assets/fc47208f-0214-49d9-834a-7747a3629a9f" />

---
**Author:** Mohammed Safwan M.
