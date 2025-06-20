
# 🚀 2-Bit Carry Skip Adder – FPGA Project (Xilinx Vivado + Verilog + Zybo Z7 FPGA)

This repository contains the **Verilog HDL implementation** of a 2-bit **Carry Skip Adder (CSKA)** and its deployment on an FPGA using **Xilinx Vivado**. This project demonstrates how to design, simulate, synthesize, and implement an optimized 2-bit adder with faster carry propagation, making it ideal for beginner and intermediate-level FPGA learners.

---

## 📚 Table of Contents

- [🔧 Project Description](#-project-description)
- [📐 Design Overview](#-design-overview)
- [📁 Project Structure](#-project-structure)
- [🧪 Simulation](#-simulation)
- [🛠️ Vivado FPGA Flow](#️-vivado-fpga-flow)
- [⚙️ Requirements](#-requirements)
- [🚀 How to Run](#-how-to-run)
- [📊 Testbench](#-testbench)
- [📸 Output Waveforms](#-output-waveforms)
- [📌 Notes](#-notes)
- [📄 License](#-license)

---

## 🔧 Project Description

The **Carry Skip Adder** enhances performance by skipping carry propagation through a block of bits when all propagate signals are asserted. In this 2-bit version:
- It includes a **CLA block** for fast internal addition.
- Carry propagation is conditionally skipped for speed optimization.
- Designed and verified using **Vivado** and tested on a **real FPGA board**.

---

## 📐 Design Overview

### 🔍 Functional Block:

     a[1:0] ──┐
              │
     b[1:0] ──┤──► cla_block ──► sum[1:0]
              │
      cin ────┘            │
                           ▼
                         cout



### 💡 Key Modules:
- `cla_block.v` – Performs 2-bit Carry Lookahead Addition
- `cska_top.v` – Integrates CLA with skip logic
- `tb_cska.v` – Testbench to verify functional correctness

---

## 📁 Project Structure

```
2-bit-cska-fpga/
├── cla_top.v
├── tb_cska.v
├── Output Waveforms     
├── README.md
```

## 🧪 Simulation

Simulate the design using Vivado Simulator:

### 🔧 Steps:

- Open Vivado → Open the project (cska_project.xpr)
- Navigate to Simulation > Run Simulation > Run Behavioral Simulation
- Verify correctness using waveform window
- Inputs are swept through all values of a[1:0], b[1:0], and cin.

## 🛠️ Vivado FPGA Flow

### ✅ Target Board:

- Zybo Z7 / Basys 3 / Nexys A7 (or any Xilinx FPGA)

### 🧩 Steps:

- Create a Vivado Project (or use provided one):
    - Add cla_block.v, cska_top.v under Design Sources
    - Add tb_cska.v under Simulation Sources

    - Add your board-specific .xdc under Constraints

- Synthesize Design:

    - Flow > Run Synthesis

- Implement Design:

    - Flow > Run Implementation

- Generate Bitstream:

    - Flow > Generate Bitstream

- Program FPGA:

    - Tools > Open Hardware Manager > Program Device

## ⚙️ Requirements

- Xilinx Vivado Design Suite
- FPGA board: Zybo Z7 / Basys 3 / Nexys A7
- USB Programmer cable
- (Optional) Logic Analyzer for hardware validation

## 🚀 How to Run
Clone the repo:
```
git clone https://github.com/<your-username>/2-bit-cska-fpga.git
cd 2-bit-cska-fpga
```
Open Vivado and launch the existing project:
```
vivado vivado_project/cska_project.xpr
```
Connect your FPGA board and generate/program bitstream.

## 📊 Testbench
The testbench (tb_cska.v) verifies all combinations of:

- a[1:0] = 00 to 11
- b[1:0] = 00 to 11
- cin = 0 and 1

It checks both the sum[1:0] and the cout for correctness and timing behavior.

## 📸 Output Waveforms

Add screenshot from Vivado waveform viewer here (optional).

Example output:

- Input:  a = 2'b10, b = 2'b01, cin = 1
- Output: sum = 2'b00, cout = 1

## 📌 Notes

- This 2-bit CSKA design is modular and scalable for higher-bit implementations.
- Ideal for educational demonstrations on performance-optimized adder design.
- Supports synthesis and deployment on real hardware using Vivado.


