# Secure Bandwidth Throttler IP

This repository contains the microarchitectural design specification for the Secure Bandwidth Throttler IP. The architecture operates within a single master clock domain and utilizes a closed-loop system layout to safeguard downstream components from high-speed data floods.

---

## 1. Top-Level Architecture Overview

The design is constructed using a sequential data processing pipeline combined with a parallel feedback control loop. 

### Data Pipeline Flow
Data routes sequentially through the core modules as illustrated below:

<img width="1069" height="561" alt="{68DEEFD4-C9EF-4F47-910C-6B1176A6C152}" src="https://github.com/user-attachments/assets/6c6eab00-5576-4a8c-8bdf-41c0bb7d7d26" />

---

## 2. Component Layout and Functional Microarchitecture

<img width="1073" height="486" alt="WhatsApp Image 2026-06-21 at 10 57 46 PM" src="https://github.com/user-attachments/assets/22e699e3-fa9a-4eba-a9c3-d72272b495f9" />



### A. Input Stage (`axis_reg_slice`)
* **Purpose:** This component acts as the physical isolation layer at the input boundary of the IP block to sever long, high-fanout combinational paths from external pins.
* **Hardware Latency:** It introduces a predictable, single clock cycle propagation delay forward.
* **Internal Block Logic:**
  * It houses a primary register bank alongside a secondary backup register (`skid_reg`).
  * **Handshake Routing:** Under normal operational conditions, it registers incoming valid data directly into the FIFO.
  * **Backpressure Management:** If the downstream FIFO buffer pulls its ready line low (`slice_to_fifo_tready == 0`), the register slice isolates the system by capturing any in-flight data word inside the `skid_reg` on the subsequent clock edge. It then immediately drops the external `s_axis_tready` signal to safely freeze the external sender.

### B. Elastic Memory Buffer (`axis_fifo`)
* **Purpose:** This is an internal buffer designed to absorb traffic bursts while the output side experiences rate regulation or total blockage.
* **Structure:** It is built as a 512-word deep internal RAM grid with a 37-bit payload width. The payload consists of 32-bit TDATA, 4-bit TKEEP, and 1-bit TLAST.
* **Internal Block Logic:**
  * **Occupancy Math:** The buffer tracks pointer locations using a write pointer (`wr_ptr_reg`) and a read pointer (`rd_ptr_reg`). The live data volume inside the memory is mathematically calculated every clock cycle: `fifo_occupancy = wr_ptr_reg - rd_ptr_reg`
  * **80% High-Watermark Line:** A dedicated hardware comparator continuously monitors the live occupancy value. The exact moment the internal depth reaches 410 words or greater, the `fifo_watermark_80` signal wire flips high to alert the control state machine.
  * **Simulation Initialization Loop:** Upon the assertion of a reset (`rst`), an internal loop automatically writes zeros across all 512 memory indices. This neutralizes uninitialized simulation states ("Red X").

### C. Bandwidth Regulator (`axis_rate_limit`)
* **Purpose:** This block serves as the active system throttle valve, enforcing strict throughput caps based on feedback commands.
* **Internal Block Logic:**
  * It reads dynamic 8-bit pacing fraction coefficients (`rate_num` and `rate_denom`) issued by the state machine.
  * **Pacing Pattern Generator:** An internal wrap-around counter counts sequentially from 1 up to the configured `rate_denom` value on every clock tick.
  * **Wait-State Injection:** Instead of dropping packets destructively, it throttles throughput by modulating its upstream ready handshake line. When instructed to apply a 25% throughput cap (01 / 04), the limiter logic holds its ready line high for exactly 1 clock cycle and forces it low for the following 3 clock cycles. This backwards injection of wait-states forces excess data to safely gather inside the upstream FIFO.

### D. Traffic Monitor (`axis_stat_counter`)
* **Purpose:** This module sits passively on the master boundary, functioning as a zero-overhead exit flow meter.
* **Internal Block Logic:**
  * **Passive Accumulation:** It continuously snoops on successful output transfers by checking if both master handshake lines (`m_axis_tvalid && m_axis_tready`) are high.
  * **Windowed Calculation:** An internal tracking counter measures traffic across a fixed observation window, such as 1,000 clock periods. It accumulates the exact number of passing data bytes throughout this specific window.
  * **FSM Interfacing:** The moment the observation window timer expires, the block pulses a `status_valid` signal and exposes the total byte sum on the `status_byte_count` bus to update the state machine. It then clears its internal accumulators back to zero in preparation for the next cycle.

### E. Central Controller (`rate_control_fsm`)
* **Purpose:** The centralized command center that connects monitoring metrics directly to active pacing gates.
* **State Logic & Conditions:**
  * **`STATE_IDLE` (`3'b001`):** The default unthrottled mode, which sets full pacing capacity (`rate_num = 100`, `rate_denom = 100`). If `status_byte_count > cfg_high_threshold_bytes` or `fifo_watermark_80 == 1'b1`, it transitions instantly into `STATE_THROTTLE`.
  * **`STATE_THROTTLE` (`3'b010`):** The active restriction mode that constrains output capacity to a 25% speed ceiling (`rate_num = 25`, `rate_denom = 100`). Once the windowed byte count falls below `cfg_low_threshold_bytes` and `fifo_watermark_80` returns to 0, it progresses to `STATE_RECOVERY`.
  * **`STATE_RECOVERY` (`3'b100`):** A safe transition mode that establishes an intermediate 50% capacity cap and initializes a 5,000-clock-cycle countdown timer. If a new traffic spike or a watermark flag occurs before the timer reaches zero, it cancels the recovery sequence and jumps immediately back to `STATE_THROTTLE`. It will only revert to full speed (`STATE_IDLE`) if the countdown timer successfully depletes completely to zero.

---

## 3. Throttling Mechanics

The architecture employs a defensive strategy by applying backpressure to both sides of the design simultaneously:

1. **Downstream (Output Side) Throttling:** The FSM commands the rate limiter to pulse its ready lines, effectively shielding downstream processing units from line-rate data floods.
2. **Upstream (Input Side) Throttling:** As wait-states accumulate, the incoming data backs up inside the FIFO. If the data flood persists and the FIFO exhausts its storage space, it drops its input ready line (`s_axis_tready`). This backpressure signal cascades up to the input source, forcing the external sender to halt transmissions until the system catches up.

---

## 4. Emergency Watermark Overdrive Logic

Under standard operating conditions, the FSM relies on the long-window byte count generated by the Traffic Monitor to trigger rate regulation. However, if a sudden downstream blockage occurs (`m_axis_tready == 0`), data will pile up rapidly inside the internal FIFO. 

Waiting for the standard monitoring window to complete its full cycle in this scenario could take hundreds of clock periods, inevitably causing a critical memory overflow. To bypass this inherent delay, the `fifo_watermark_80` signal is wired as an immediate override path directly into the FSM. On the exact clock edge where the buffer occupancy strikes 410 words, this override forces the FSM into `STATE_THROTTLE` on the very next clock cycle. This specialized mechanism guarantees instant upstream backpressure propagation and ensures total overflow protection independent of the monitoring window's status.
