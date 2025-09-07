# Vending_Machine

---

# 🏪 Vending Machine Controller – Verilog 

This project presents a clean Verilog implementation of a **Finite State Machine (FSM)-based vending machine controller**, designed for deployment on Xilinx FPGA platforms using Vivado. It handles money insertion, item selection, dispensing, and change-return logic in a structured and synthesizable form.

---

## Project Overview

* **Objective**: Realize a state-driven vending machine controller leveraging Verilog HDL to manage user inputs and outputs effectively.
* **Technologies Used**:

  * **Verilog HDL** — for core FSM functionality (`vending_machine.v`, `vending_machine_tb.v`)
  * **Xilinx Vivado** — for FPGA synthesis, implementation, and bitstream generation
* **Contents**:

  * `vending_machine.v` — Verilog HDL module implementing vending logic
  * `vending_machine_tb.v` — Corresponding testbench for simulation
  * *(Optionally, include waveforms or block diagrams if available)*

---

## Repository Structure

```
Vending_Machine/
├── vending_machine.v         # Core FSM logic (Verilog)
├── vending_machine_tb.v      # Simulation testbench
├── README.md                 # Project documentation
└── (Optional: waveforms/, docs/, Vivado project files)
```

---

## ▶ Quick Start Guide

### 1. Clone the Repository

```bash
git clone https://github.com/SivaKarthik9804/Vending_Machine.git
cd Vending_Machine
```

### 2. Simulate the Design

Use Xilinx Vivado :

```bash
iverilog -o vmachine vending_machine.v vending_machine_tb.v
vvp vmachine
```

As an enhancement, use GTKWave or Vivado’s simulator to visualize signal activity and FSM behavior.

### 3. FPGA Deployment with Vivado

Steps to synthesize and implement:

1. Launch Xilinx Vivado and create a new RTL project.
2. Add `vending_machine.v` to the design sources.
3. Define the target FPGA board (e.g., Basys-3, Artix-7).
4. Map IO pins for inputs (coins, selections, reset) and outputs (dispense signal, change).
5. Run **Synthesis → Implementation → Generate Bitstream**.
6. Program your FPGA board to test functionality in hardware.

---

## How It Works (FSM Logic Overview)

1. **Idle State**: Machine awaits money insertion or cancellation.
2. **Money Accumulation**: FSM tracks denominations entered (e.g., multiple coins until total meets or exceeds selected item price).
3. **Selection & Dispensing**:

   * If exact payment, dispense item.
   * If overpayment, dispense item *and* return change.
4. **Cancel Mechanism**: If the user aborts mid-way, the system resets and refunds the entered amount.
5. **Reset Behavior**: An external reset clears the state and returns to Idle.

---

## Applications & Future Directions

**Use Cases**:

* Demonstrates digital FSM design for academic use or FPGA prototyping.
* Can serve as a foundation for interactive embedded systems with user interfaces.

**Potential Enhancements**:

* Add a **Graphical User Interface (via push buttons/7-segment LEDs or VGA)** for real-time interaction.
* Design the FSM as a **Mealy machine** for faster response to inputs.
* Support multiple products with varying prices and inventory tracking.
* Transition to ASIC design using open-source flows like OpenLane + SkyWater Sky130.
* Incorporate formal verification to guarantee correctness under all input scenarios.

---

## Author

**Siva Karthik**
Aspiring VLSI Engineer & ECE Enthusiast
GitHub: [SivaKarthik9804](https://github.com/SivaKarthik9804)

---

