# SystemVerilog FIFO Transaction Class

## 📌 Overview
This repository contains a SystemVerilog transaction class (`fifo_transaction`) designed to generate stimulus for a FIFO (First-In-First-Out) hardware verification environment. By leveraging **Constrained Randomization**, this class automatically generates valid, varied, and realistic test vectors while preventing illegal hardware states.

## 🏗️ Class Architecture
The transaction class acts as a software abstraction of the physical FIFO pins, grouping the inputs and outputs into a single object.

### 🔌 Variables & Signals
* **Randomized Stimulus (Inputs):**
  * `data_in` (8-bit): The data payload to be written into the FIFO.
  * `wr_enb` (1-bit): Write enable signal.
  * `rd_enb` (1-bit): Read enable signal.
* **Observed Status (Outputs):**
  * `data_out` (8-bit): The data read out of the FIFO.
  * `full` (1-bit): Indicates the FIFO has reached maximum capacity.
  * `empty` (1-bit): Indicates the FIFO has no data left to read.

### 🛡️ Randomization Constraints
The class uses SystemVerilog `constraint` blocks to control how the random solver generates numbers:
1. **Data Boundaries (`c_1`):** Restricts the randomized `data_in` payload to fall strictly between a user-defined `min` and `max` value during write operations.
2. **Mutual Exclusion (`c_2`):** Hardware protection that prevents simultaneous read and write operations (`wr_enb` and `rd_enb` are never `1` at the same time).
3. **Activity Distribution (`c_3`):** Forces a 50/50 probability distribution for the read and write enables, ensuring the testbench actively tries to read and write rather than getting stuck on a single state.
4. **Read-State Data Masking (`c_4`):** Ensures that the input data bus is explicitly zeroed out (`data_in == 0`) whenever a read operation occurs (`rd_enb == 1`).

### ⚙️ Built-in Methods
* `set_boundaries(int min_value, int max_value)`: A custom setup function used to dynamically configure the `min` and `max` limits for the data payload before calling randomization.
* `post_randomize()`: A native SystemVerilog callback function that automatically prints the randomized stimulus to the kernel console the moment `randomize()` is successful.
* `display(string s)`: A utility function that cleanly prints the entire state of the transaction (both inputs and outputs) for easy testbench debugging.
