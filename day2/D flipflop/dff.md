# D Flip-Flop with Asynchronous Reset in Verilog

## 📌 Project Overview
This repository contains the Verilog RTL design and verification environment for a standard D (Data) Flip-Flop. The design includes an active-high asynchronous reset, ensuring the outputs can be initialized to a known state independently of the clock signal. Both the true output (`q`) and the complemented output (`qbar`) are provided.

## 📁 File Structure
* **`dff.v`**: The main RTL design file implementing the D Flip-Flop behavior.
* **`dff_tb.v`**: The testbench module used to verify the functionality, timing, and reset conditions of the flip-flop.

## 🛠️ Tools Used
* **Hardware Description Language:** Verilog
* **Simulation & Synthesis:** Xilinx Vivado

## 📊 Expected Simulation Results
The `dff_tb` module generates a 10ns period clock (toggling every 5ns) and applies a sequence of resets and data inputs. Below is the expected behavior over the first 30ns:

| Time (ns) | `clk_tb` | `rst_tb` | `d_tb` (Data) | Expected `q_tb` | Expected `qbar_tb` | Operation |
| :---: | :---: | :---: | :---: | :---: | :---: | :--- |
| **0** | 0 | 1 | 0 | **0** | **1** | System initialized. Reset is HIGH. |
| **5** | 1 ↑ | 1 | 0 | **0** | **1** | Clock rises, but Reset is still HIGH. |
| **10** | 0 | 0 | 0 | **0** | **1** | Reset pulled LOW. Awaiting next clock edge. |
| **15** | 1 ↑ | 0 | 0 | **0** | **1** | Clock rises. `D=0` is clocked into `Q`. |
| **20** | 0 | 0 | 1 | **0** | **1** | `D` changes to `1`, but `Q` holds previous state. |
| **25** | 1 ↑ | 0 | 1 | **1** | **0** | Clock rises. `D=1` is clocked into `Q`. |

## 📈 Simulation Waveform
<img width="1415" height="685" alt="dff" src="https://github.com/user-attachments/assets/b0ef30ab-b93e-46ce-aee0-d983c9e57816" />


**Author:** Mohammed Safwan M.
