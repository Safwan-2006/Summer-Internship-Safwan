# SR Flip-Flop in Verilog

## 📌 Project Overview
This repository contains the Verilog RTL design and verification environment for a Synchronous SR (Set-Reset) Flip-Flop. The design incorporates an asynchronous active-high reset (which initializes the output to a high state) and evaluates the `S` and `R` inputs on the positive edge of the clock. 

## 📁 File Structure
* **`sr_ff.v`**: The main RTL design file implementing the behavioral logic of the SR Flip-Flop, including state retention (hold), set, reset, and the invalid state (`1'bx`).
* **`sr_ff_tb.v`**: The testbench module used to verify the state transitions of the flip-flop across all possible input combinations.

## 🛠️ Tools Used
* **Hardware Description Language:** Verilog
* **Simulation & Synthesis:** Xilinx Vivado

## 📊 Expected Simulation Results
The `sr_ff_tb` module generates a 10ns period clock and tests the flip-flop through its complete truth table. Below is the expected behavior over the simulation timeline:

| Time (ns) | `rst_tb` | `s_tb` (Set) | `r_tb` (Reset) | Expected `q_tb` | Expected `qbar_tb` | Operation State |
| :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **0 - 10** | 1 | 0 | 0 | **1** | **0** | **Asynchronous Reset** (Initializes `Q` to 1). |
| **10 - 20** | 0 | 0 | 0 | **1** | **0** | **Hold State:** Retains the previous state. |
| **20 - 30** | 0 | 0 | 1 | **0** | **1** | **Reset State:** Clears `Q` to 0. |
| **30 - 40** | 0 | 1 | 0 | **1** | **0** | **Set State:** Sets `Q` to 1. |
| **40+** | 0 | 1 | 1 | **X** | **X** | **Invalid State:** Outputs driven to unknown (`X`). |

## 📈 Simulation Waveform
<img width="1544" height="682" alt="srff" src="https://github.com/user-attachments/assets/81ca4a70-7182-4260-a012-1872165647a3" />
---
**Author:** Mohammed Safwan M.
