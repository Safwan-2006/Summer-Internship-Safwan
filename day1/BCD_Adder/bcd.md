# 4-Bit BCD Adder in Verilog

## 📌 Overview
This repository contains the Verilog RTL code and testbench for a **4-Bit Binary Coded Decimal (BCD) Adder**. The design uses structural modeling, instantiating two Ripple Carry Adders (RCAs) to compute the addition and perform necessary corrections for valid BCD outputs.

## ⚙️ Design Architecture
In BCD addition, if the sum of two 4-bit numbers exceeds `9` (binary `1001`) or generates a carry-out, it results in an invalid BCD state. To correct this, we must add `6` (binary `0110`) to the sum. 

The structural logic in `BCD_ADDER.v` handles this process in two stages:
1. **First Stage (RCA1):** Adds the two 4-bit inputs (`a` and `b`) along with the carry-in (`c`). It generates a preliminary 4-bit sum (`s`) and a carry-out (`cout1`).
2. **Correction Logic:** A boolean logic expression checks if the preliminary sum exceeds 9 or if a carry was generated:
   `cout = cout1 | (s[3] & s[2]) | (s[3] & s[1])`
3. **Second Stage (RCA2):** If `cout` is `1`, the correction word `w` becomes `0110` (6). If `cout` is `0`, `w` remains `0000` (0). This word is added to the preliminary sum to produce the final, valid BCD `sum` and the final carry-out.

## 📂 File Structure
* `BCD_ADDER.v` — The top-level module containing the BCD addition and correction logic.
* `BCD_ADDER_tb.v` — The testbench used to verify the design against various test cases.
* `RIPPLE_CARRY_ADDER.v` — *(Note: Ensure this dependency file is uploaded to the repository, as the top module instantiates it twice).*

## 🛠️ Tools & Technologies
* **Hardware Description Language:** Verilog HDL
* **Simulation/Synthesis Tool:** Xilinx Vivado (or any standard Verilog simulator)

## 📊 Testbench & Simulation Results

The testbench (`BCD_ADDER_tb.v`) evaluates the adder using the following sequence of inputs to verify both valid and invalid BCD intermediate states:

| Time | Input `a` | Input `b` | `cin` | Expected Decimal | BCD `sum` | BCD `cout` | Correction Needed? |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| 0 ns | `0000` (0) | `0000` (0) | `0` | 0 | `0000` (0) | `0` | No |
| 50 ns | `0010` (2) | `0011` (3) | `0` | 5 | `0101` (5) | `0` | No |
| 100 ns | `0101` (5) | `0100` (4) | `0` | 9 | `1001` (9) | `0` | No |
| 150 ns | `0110` (6) | `0111` (7) | `0` | 13 | `0011` (3) | `1` | Yes (Sum > 9) |
| 200 ns | `1000` (8) | `1000` (8) | `0` | 16 | `0110` (6) | `1` | Yes (Carry out) |

### 📈 Waveform Output
*(Add your simulation waveform screenshot here)* `![Simulation Waveform](link-to-your-image.png)`


