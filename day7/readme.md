# AMBA APB Slave with SystemVerilog Testbench

![SystemVerilog](https://img.shields.io/badge/Language-SystemVerilog-blue.svg)
![Protocol](https://img.shields.io/badge/Protocol-AMBA_APB-green.svg)
![EDA](https://img.shields.io/badge/Simulator-Vivado_XSim-orange.svg)

This repository contains the RTL design of a basic Advanced Peripheral Bus (APB) Slave module and a fully layered, object-oriented SystemVerilog testbench used to verify its functionality. 

## 📌 Project Overview
The APB Slave is designed with a 256-word x 32-bit internal memory. It supports zero-wait-state read and write operations compliant with the AMBA APB protocol specifications. 

The verification environment is built using SystemVerilog classes, structured similarly to UVM (Universal Verification Methodology) fundamentals, including:
* **Transaction:** Defines randomized APB packet attributes (`paddr`, `pwdata`, `pwrite`).
* **Generator:** Creates randomized stimulus and passes it to the driver via mailboxes.
* **Driver:** Translates transaction objects into pin-level APB protocol signaling.
* **Monitor:** Observes bus activity and captures completed transactions.
* **Scoreboard:** Maintains a reference memory model and self-checks read data against expected values.
* **Environment:** Encapsulates and connects all verification components.

## 📂 File Structure
* `apb_slave.v` - The RTL implementation of the APB memory-mapped slave.
* `testbench.sv` - The top-level layered SystemVerilog testbench.

---

## 🌊 Simulation Waveforms and Details

<img width="1555" height="663" alt="image" src="https://github.com/user-attachments/assets/49994907-93c4-42c0-aeec-d32706be8661" />


### Waveform Analysis
The simulation demonstrates successful APB protocol compliance across both read and write transactions. The key phases captured in the waveform are:

1. **SETUP Phase:**
   * The master asserts the select signal (`psel = 1`).
   * The enable signal remains low (`penable = 0`).
   * Address (`paddr`), write control (`pwrite`), and write data (`pwdata`) are driven and held stable.

2. **ACCESS Phase:**
   * Exactly one clock cycle after SETUP, the master asserts the enable signal (`penable = 1`).
   * The slave responds by asserting the ready signal (`pready = 1`).
   * Because `pready` is asserted immediately, this acts as a **0-wait-state** transfer, and the transaction completes on the current clock edge.

3. **Data Transfer & IDLE:**
   * **Write (`pwrite = 1`):** The data on `pwdata` (e.g., `32'ha178a3d9`) is successfully latched into the slave's internal memory at the specified `paddr`.
   * **Read (`pwrite = 0`):** The slave successfully places the requested data onto the `prdata` bus.
   * Following the transaction, the bus gracefully returns to the IDLE state (`psel = 0`, `penable = 0`).

---

