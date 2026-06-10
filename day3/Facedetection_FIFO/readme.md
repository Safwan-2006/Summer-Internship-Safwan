# Face Detection Data Processing using FIFO (Verilog RTL)

## 📌 Project Overview

This repository contains the Verilog RTL implementation and verification of a FIFO-based data rate matching system for face detection data processing.

The design consists of three main modules:

1. **Face Module (Producer)** – Captures incoming 8-bit image data and writes it into the FIFO.
2. **FIFO Buffer** – Temporarily stores image data and handles rate matching between producer and consumer.
3. **Output Face Module (Consumer FSM)** – Reads data from the FIFO and outputs it at a slower processing rate.

The FIFO prevents data loss and ensures reliable communication between modules operating at different effective processing speeds.

---

## 🎯 Objective

The objective of this project is to design and implement a Verilog-based hardware system for face detection data processing using a FIFO buffer to perform data rate matching between a high-speed image acquisition module and a slower face processing module.

The system consists of:

* A producer module that continuously captures and stores image data.
* A FIFO buffer that temporarily holds the data.
* A consumer FSM that processes the data at a lower rate.

The FIFO ensures reliable data transfer without loss or corruption when the input and processing rates differ.

The design demonstrates the use of:

* Finite State Machines (FSMs)
* FIFO Memory Architecture
* Flow Control Signals
* Synchronous Digital Design Techniques

for efficient real-time image processing applications.

---

## 🏗️ System Architecture

```text
         +----------------+
s_in --->|  Face Module   |
         |  (Producer)    |
         +-------+--------+
                 |
                 | wr_en
                 v
         +----------------+
         |      FIFO      |
         |   8 x 8-bit    |
         +-------+--------+
                 |
                 | rdenb
                 v
         +----------------+
         | Output Face    |
         | Module (FSM)   |
         | (Consumer)     |
         +-------+--------+
                 |
                 v
               dout
```

---

## 📁 File Structure

This project is organized into RTL design files and verification files. The `top_module` integrates all submodules into a complete FIFO-based data rate matching system, while the testbench validates the overall functionality.

### RTL Design Files

#### `face_module.v`

Producer module responsible for accepting incoming 8-bit image data and transferring it to the FIFO buffer. It generates the FIFO write enable (`wr_en`) signal whenever the FIFO is not full.

#### `FIFO.v`

An 8-depth, 8-bit synchronous FIFO memory used for temporary data storage. It manages data transfer between the producer and consumer modules and generates `full` and `empty` status flags for flow control.

#### `output_face_module.v`

Consumer Finite State Machine (FSM) that reads data from the FIFO when data is available. It generates the FIFO read enable (`rdenb`) signal and outputs the retrieved data.

#### `top_module.v`

Top-level integration module that connects the Producer (`face_module`), FIFO (`FIFO`), and Consumer (`output_face_module`) modules together to form the complete data rate matching system.

---

### Verification Files

#### `top_module_tb.v`

Top-level testbench used to verify the complete system. It instantiates the `top_module`, generates clock and reset signals, applies input test vectors, and verifies correct FIFO read/write operations and data transfer between modules.



## ⚙️ Design Features

### Face Module

* Receives 8-bit input data.
* Writes data into FIFO whenever FIFO is not full.
* Prevents overflow using FIFO full flag.

### FIFO Buffer

* Memory Depth: 8 locations
* Data Width: 8 bits
* Circular pointer implementation
* Full and Empty status generation
* Supports simultaneous read and write operations

### Output Face Module

* FSM-based controller
* Reads FIFO data only when available
* Generates read enable signal
* Outputs valid data after synchronous FIFO read

---

## 🛠️ Tools Used

* Hardware Description Language: Verilog HDL
* Simulator: Xilinx Vivado Simulator
* Synthesis Tool: Xilinx Vivado

---

## 📊 Expected Simulation Results

The testbench continuously sends image data through the producer module.

### Expected Behavior

1. Producer writes incoming data into FIFO.
2. FIFO occupancy increases.
3. Consumer FSM detects non-empty FIFO.
4. Read enable (`rdenb`) is generated.
5. FIFO outputs stored data.
6. Consumer captures FIFO output and drives `dout`.
7. Data appears at output in the same order it was written.

### Example Data Flow

| Clock Cycle | Input (s_in) | FIFO Operation | Output (dout) |
| ----------- | ------------ | -------------- | ------------- |
| 1           | 8'h11        | Write          | -             |
| 2           | 8'h22        | Write          | -             |
| 3           | 8'h33        | Write          | 8'h11         |
| 4           | 8'h44        | Write          | 8'h22         |
| 5           | 8'h55        | Write          | 8'h33         |
| 6           | 8'h66        | Write          | 8'h44         |



---


## 📈 Simulation Waveform



### Waveform Screenshot

<img width="1878" height="875" alt="face_detection" src="https://github.com/user-attachments/assets/709a747a-5e7a-4f71-9b42-e7ea0ae1cfee" />

---

## 🔧 Synthesis Results

The design was synthesized using **Xilinx Vivado** to evaluate hardware resource utilization and verify synthesizability.

### Generated Reports

The following synthesis reports were generated:


### Synthesis Report Screenshot



<img width="1328" height="81" alt="image" src="https://github.com/user-attachments/assets/a76d5843-46ad-42e5-a235-25027799198d" />


### Synthesis Summary

The design was successfully synthesized without errors and demonstrates a hardware-efficient implementation of a FIFO-based data rate matching system. The synthesis reports confirm that the Producer Module, FIFO Buffer, Consumer FSM, and Top Module were correctly inferred and optimized by the synthesis tool.


---
**Author:** Mohammed Safwan M.



