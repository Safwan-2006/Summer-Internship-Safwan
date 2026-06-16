# SystemVerilog FIFO Transaction Generator

## 📌 Project Overview
This repository contains a SystemVerilog transaction class (sequence item) and a self-contained testbench for a FIFO verification environment. The design leverages SystemVerilog's **Constrained Randomization** to generate valid stimulus for a FIFO Device Under Test (DUT). It includes built-in constraints to set data boundaries, enforce realistic read/write distributions, prevent illegal states (like simultaneous reads and writes), and **ensure the input data bus is zeroed out during read operations**.

## 📁 File Structure
* **`fifo_transaction.sv`**: Contains both the `fifo_transaction` class and the top-level testbench (`module tb`). 
  * The class handles the randomization variables (`rand`), constraints (`c_1`, `c_2`, `c_3`, `c_4`), and display methods.
  * The testbench acts as a simple generator, instantiating the object, setting boundaries (e.g., 2 to 50), and running a loop to generate valid transactions.

## 🛠️ Tools Used
* **Hardware Verification Language:** SystemVerilog
* **Simulation:** Xilinx Vivado (or any standard SystemVerilog simulator like ModelSim/Questa)

## 📊 Expected Simulation Results (Kernel Log)
The `tb` module applies boundaries to the `data_in` variable during write operations. Due to the built-in `post_randomize()` function and the explicit `$display` in the loop, each transaction prints twice. 

Notably, constraint `c_4` (`rd_enb -> (data_in == 0)`) is actively working here: whenever a read operation occurs (`RD: 1`), the `DATA_IN` bus is automatically driven to `0`.

Below is the expected TCL console output demonstrating that the constraints are working perfectly:

```text
# KERNEL: Transaction Randomized -> WR: 1 | RD: 0 | DATA_IN: 28
# KERNEL: Value of wr_enb is 1, rd_enb is 0, data_in is 28
# KERNEL: Transaction Randomized -> WR: 0 | RD: 1 | DATA_IN: 0
# KERNEL: Value of wr_enb is 0, rd_enb is 1, data_in is 0
# KERNEL: Transaction Randomized -> WR: 0 | RD: 1 | DATA_IN: 0
# KERNEL: Value of wr_enb is 0, rd_enb is 1, data_in is 0
# KERNEL: Transaction Randomized -> WR: 0 | RD: 1 | DATA_IN: 0
# KERNEL: Value of wr_enb is 0, rd_enb is 1, data_in is 0
# KERNEL: Transaction Randomized -> WR: 0 | RD: 1 | DATA_IN: 0
# KERNEL: Value of wr_enb is 0, rd_enb is 1, data_in is 0
# KERNEL: Transaction Randomized -> WR: 1 | RD: 0 | DATA_IN: 41
# KERNEL: Value of wr_enb is 1, rd_enb is 0, data_in is 41
# KERNEL: Transaction Randomized -> WR: 0 | RD: 1 | DATA_IN: 0
# KERNEL: Value of wr_enb is 0, rd_enb is 1, data_in is 0
# KERNEL: Transaction Randomized -> WR: 0 | RD: 1 | DATA_IN: 0
# KERNEL: Value of wr_enb is 0, rd_enb is 1, data_in is 0
# KERNEL: Transaction Randomized -> WR: 0 | RD: 1 | DATA_IN: 0
# KERNEL: Value of wr_enb is 0, rd_enb is 1, data_in is 0
# KERNEL: Transaction Randomized -> WR: 1 | RD: 0 | DATA_IN: 26
# KERNEL: Value of wr_enb is 1, rd_enb is 0, data_in is 26
```
---

**Author:** Mohammed Safwan M.
