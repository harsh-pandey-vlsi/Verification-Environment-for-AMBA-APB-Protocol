# APB Master-Slave RTL Design and Verification

## Overview

This project implements a parameterized **AMBA APB3 (Advanced Peripheral Bus)** Master-Slave communication system in SystemVerilog. The design supports configurable address width, data width, memory depth, programmable wait states, and error handling. A mailbox-based constrained-random verification environment is developed to verify protocol compliance and functional correctness using assertions, functional coverage, and a scoreboard.

---

## Features

### RTL Design

* APB3-compliant Master
* APB3-compliant Slave
* Parameterized Address Width
* Parameterized Data Width
* Configurable Memory Depth
* Configurable Wait States
* Read and Write Transactions
* Error Handling using PSLVERR
* Synthesizable SystemVerilog RTL

### Verification Environment

* Mailbox-Based Verification Architecture
* Constrained-Random Transaction Generation
* Driver and Monitor Components
* Reference Model Scoreboard
* Functional Coverage Collection
* SystemVerilog Assertions (SVA)
* Coverage Closure through Directed Testing

---

## Directory Structure

```text
project/
│
├── rtl/
│   ├── apb_master.sv
│   ├── apb_slave.sv
│   └── apb_top.sv
│
├── tb/
│   ├── apb_if.sv
│   ├── apb_transaction.sv
│   ├── apb_generator.sv
│   ├── apb_driver.sv
│   ├── apb_monitor.sv
│   ├── apb_scoreboard.sv
│   ├── apb_coverage.sv
│   ├── apb_assertions.sv
│   ├── apb_env.sv
│   └── top_tb.sv
│
└── README.md
```

---

## Simulation Flow

1. Generate constrained-random APB transactions.
2. Driver applies transactions to DUT.
3. APB Master initiates bus transfer.
4. APB Slave responds with wait states and data.
5. Monitor captures completed transactions.
6. Scoreboard validates data integrity.
7. Assertions verify protocol compliance.
8. Coverage model tracks verification progress.

---

## Results

### Functional Verification

* Scoreboard-based data checking
* Read/Write transaction validation
* Error response verification
* Wait-state handling verification

### Coverage Metrics

* Functional Coverage > 85%
* Assertion-Based Protocol Checking
* Directed Tests for Coverage Closure

---

## Tools Used

* SystemVerilog
* ModelSim / QuestaSim
* EDA Playground
* Git
* GitHub

---

## Future Improvements

* APB4 Support
* Register-Based Slave Architecture
* Multi-Slave APB Interconnect
* UVM-Based Verification Environment
* Formal Verification
* Functional Coverage Closure > 95%
* Synthesis and Timing Analysis

---

## Author

Harsh Pandey

Electronics and Communication Engineering (ECE)

RTL Design | Design Verification | RISC-V | AMBA Protocols
