# 4-to-2 Encoder in Verilog

## 📌 Project Overview
This repository contains the Verilog RTL design and verification environment for a 4-to-2 Encoder using behavioral modeling. The circuit is designed to compress a 4-bit one-hot input vector ($D_0, D_1, D_2, D_3$) into a 2-bit binary output ($Y_0, Y_1$). In a strict one-hot encoder setup, only one input is actively driven high at any given time.


## 📁 File Structure
* **`Encoder_4by2.v`**: The main RTL design file implementing the encoder logic. It utilizes a behavioral `always` block and a `case` statement to evaluate the 4-bit input vector and map it to the 2-bit output, including a default state to prevent inferred latches during synthesis.
* **`Encoder_4by2_tb.v`**: The testbench module. It programmatically generates one-hot input stimuli using a `for` loop (shifting the active bit leftward: 1, 2, 4, 8) and logs the output responses to the console using `$monitor`.

## 🛠️ Tools Used
* **Hardware Description Language:** Verilog
* **Simulation & Synthesis:** Xilinx Vivado

## 📊 Expected Simulation Results
The `encoder4to2_tb` evaluates the design by walking a logic high (`1`) through each of the four input positions. Below is the expected truth table representing the theoretical and simulated behavior:

| Decimal Input | 4-Bit One-Hot Input (`D3 D2 D1 D0`) | Expected 2-Bit Output (`Y1 Y0`) |
| :---: | :---: | :---: |
| **1** | `0001` | **`00`** |
| **2** | `0010` | **`01`** |
| **4** | `0100` | **`10`** |
| **8** | `1000` | **`11`** |
| **Other** | `Others` | **`00`** *(Default Case)* |

## 📈 Simulation Waveform
<img width="1550" height="627" alt="encoder" src="https://github.com/user-attachments/assets/9d426d01-fc98-43f3-b72b-51f685feb26f" />

**Author:** Mohammed Safwan M.
