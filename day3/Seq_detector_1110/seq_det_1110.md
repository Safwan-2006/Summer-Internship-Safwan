# "1110" Sequence Detector in Verilog

## 📌 Project Overview
This repository contains the Verilog RTL design and verification environment for a Finite State Machine (FSM) that detects the binary sequence **"1110"**. The design is implemented as a Mealy state machine with four distinct states (`idle`, `s1`, `s2`, `s3`). The system resets to the `idle` state and outputs a high signal (`detected = 1`) immediately upon detecting the complete "1110" pattern.

## 📁 File Structure
* **`seq_detector_1110.v`**: The top-level module implementing the FSM sequence detector logic.
* **`seq_detector_1110_tb.v`**: The testbench for verifying the functionality of the sequence detector.

## 🛠️ Tools Used
* **Hardware Description Language:** Verilog
* **Simulation & Synthesis:** Xilinx Vivado

## 📊 Expected Simulation Results
The `seq_detector_1110_tb` initializes the system with a reset and then applies a sequential input stream to verify the state transitions. With a clock period of 10ns, the expected theoretical outputs based on the applied stimuli are:

| Time (ns) | `rst_tb` (Reset) | `din_tb` (Input) | Present State | Expected `detected_tb` | Notes |
| :---: | :---: | :---: | :---: | :---: | :--- |
| 0 - 10 | `1` | `0` | `idle` | `0` | Reset is active. System initializes to `idle`. |
| 10 - 20 | `0` | `1` | `idle` ➔ `s1` | `0` | Reset deasserted. First `1` is applied. |
| 20 - 30 | `0` | `1` | `s1` ➔ `s2` | `0` | Second `1` is applied. |
| 30 - 40 | `0` | `1` | `s2` ➔ `s3` | `0` | Third `1` is applied. |
| 40 - 50 | `0` | `0` | `s3` ➔ `idle` | `1` | The final `0` is applied. Sequence **"1110"** detected! Output goes HIGH. |

## 📈 Simulation Waveform
<img width="1556" height="709" alt="seq_detector_1110" src="https://github.com/user-attachments/assets/316c97c6-dbaa-44c9-968b-55909807638b" />


---
**Author:** Mohammed Safwan M.
