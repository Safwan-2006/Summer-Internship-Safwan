
# SystemVerilog FIFO Transaction Generator

## 📌 Project Overview
This repository contains a SystemVerilog transaction class (sequence item) and a self-contained testbench for a FIFO verification environment. The design leverages SystemVerilog's **Constrained Randomization** to generate valid stimulus for a FIFO Device Under Test (DUT). It includes built-in constraints to set data boundaries, enforce realistic read/write distributions, and prevent illegal states (like simultaneous reads and writes).

## 📁 File Structure
* **`fifo_transaction.sv`**: Contains both the `fifo_transaction` class and the top-level testbench (`module tb`). 
  * The class handles the randomization variables (`rand`), constraints (`c_1`, `c_2`, `c_3`), and display methods.
  * The testbench acts as a simple generator, instantiating the object, setting boundaries (2 to 50), and running a loop to generate 10 valid transactions.

## 🛠️ Tools Used
* **Hardware Verification Language:** SystemVerilog
* **Simulation:** Xilinx Vivado (or any standard SystemVerilog simulator like ModelSim/Questa)

## 📊 Expected Simulation Results (Kernel Log)
The `tb` module applies boundaries of `min=2` and `max=50` to the `data_in` variable and generates 10 transactions. Due to the built-in `post_randomize()` function and the explicit `$display` in the loop, each transaction prints twice. 

Below is the expected TCL console output demonstrating that the constraints (no simultaneous read/write, bounded data) are working perfectly:

```text
# KERNEL: Transaction Randomized -> WR: 1 | RD: 0 | DATA_IN: 42
# KERNEL: Value of wr_enb is 1, rd_enb is 0, data_in is 42
# KERNEL: Transaction Randomized -> WR: 0 | RD: 0 | DATA_IN: 15
# KERNEL: Value of wr_enb is 0, rd_enb is 0, data_in is 15
# KERNEL: Transaction Randomized -> WR: 0 | RD: 1 | DATA_IN: 7
# KERNEL: Value of wr_enb is 0, rd_enb is 1, data_in is 7
# KERNEL: Transaction Randomized -> WR: 0 | RD: 0 | DATA_IN: 33
# KERNEL: Value of wr_enb is 0, rd_enb is 0, data_in is 33
# KERNEL: Transaction Randomized -> WR: 1 | RD: 0 | DATA_IN: 49
# KERNEL: Value of wr_enb is 1, rd_enb is 0, data_in is 49
# KERNEL: Transaction Randomized -> WR: 0 | RD: 1 | DATA_IN: 22
# KERNEL: Value of wr_enb is 0, rd_enb is 1, data_in is 22
# KERNEL: Transaction Randomized -> WR: 0 | RD: 0 | DATA_IN: 11
# KERNEL: Value of wr_enb is 0, rd_enb is 0, data_in is 11
# KERNEL: Transaction Randomized -> WR: 0 | RD: 0 | DATA_IN: 4
# KERNEL: Value of wr_enb is 0, rd_enb is 0, data_in is 4
# KERNEL: Transaction Randomized -> WR: 1 | RD: 0 | DATA_IN: 28
# KERNEL: Value of wr_enb is 1, rd_enb is 0, data_in is 28
# KERNEL: Transaction Randomized -> WR: 0 | RD: 0 | DATA_IN: 39
# KERNEL: Value of wr_enb is 0, rd_enb is 0, data_in is 39
```
---

**Author:** Mohammed Safwan M.
