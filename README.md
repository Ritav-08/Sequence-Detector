# Sequence Detector for Pattern "1011" (Mealy FSM) - Verilog

## Overview

This project implements a Sequence Detector using a Mealy Finite State Machine (FSM) in Verilog HDL. The detector identifies the binary sequence `1011` from a serial input stream and generates an output pulse whenever the pattern is detected.

The design supports overlapping sequence detection and uses asynchronous reset.

---

## Design Description

### Sequence Detector

- Detects the binary pattern `1011`
- Accepts serial input (`data_i`)
- Generates output pulse (`dout_o`) when the sequence is detected
- Supports overlapping pattern detection
- Uses Mealy FSM architecture
- Uses asynchronous active-HIGH reset

---

## Module Details

### FSM Module

```verilog
module sdFSM1011(
   input      data_i,
   input      rst_i,
   input      clk_i,
   output reg dout_o
);
```

### Inputs

- `data_i` → Serial input data
- `clk_i`  → Clock signal
- `rst_i`  → Active HIGH asynchronous reset

### Output

- `dout_o` → Pattern detection output

---

## State Diagram

| State | Meaning |
|---------|---------|
| S0 | Initial state / No match |
| S1 | Detected '1' |
| S2 | Detected '10' |
| S3 | Detected '101' |

---

## State Transitions

### S0 (Initial State)

| Input | Next State |
|---------|------------|
| 0 | S0 |
| 1 | S1 |

---

### S1 (Detected '1')

| Input | Next State |
|---------|------------|
| 0 | S2 |
| 1 | S1 |

---

### S2 (Detected '10')

| Input | Next State |
|---------|------------|
| 0 | S0 |
| 1 | S3 |

---

### S3 (Detected '101')

| Input | Next State | Output |
|---------|------------|---------|
| 0 | S2 | 0 |
| 1 | S1 | 1 |

Pattern `1011` is detected when the FSM is in state S3 and receives input `1`.

---

## Pattern Detection Example

Input Stream:

```text
1 0 1 1
```

State Transition:

```text
S0 → S1 → S2 → S3 → DETECT
```

Output:

```text
0 0 0 1
```

---

## Overlapping Detection

The FSM supports overlapping patterns.

Example:

```text
Input : 1011011
```

Detected sequences:

```text
1011
   1011
```

Output:

```text
0001001
```

---

## Testbench Description

The testbench performs the following:

- Generates clock signal
- Applies asynchronous reset
- Generates random input bits
- Injects known sequence `1011`
- Stores recent input bits in a shift register
- Monitors simulation activity
- Generates waveform dump file

---

## Testbench Operation

### Clock Generation

```verilog
initial begin
   clk_ti = 1'b0;
   forever #5 clk_ti = ~clk_ti;
end
```

Clock Period:

```text
10 Time Units
```

---

### Reset Operation

```verilog
rst_ti = 1'b1;
#3 rst_ti = 1'b0;
```

The FSM starts from state S0.

---

### Sequence Injection

The testbench intentionally applies:

```text
1 → 0 → 1 → 1
```

to verify correct detection of the target pattern.

---

## Sample Simulation Output

```text
Time: 80, Clk: 1, Rst: 0, IN: 1, OUT: 0
Time: 90, Clk: 1, Rst: 0, IN: 0, OUT: 0
Time: 100, Clk: 1, Rst: 0, IN: 1, OUT: 0
Time: 110, Clk: 1, Rst: 0, IN: 1, OUT: 1
```

The output pulse at time 110 indicates successful detection of the sequence `1011`.

---

## Waveform

Generated waveform file:

```text
sdFSM1011.vcd
```

View waveform using GTKWave:

```bash
gtkwave sdFSM1011.vcd
```

---

## How to Run (Icarus Verilog)

### Compile

```bash
iverilog -o sdFSM1011 sdFSM1011.v
```

### Run Simulation

```bash
vvp sdFSM1011
```

### Open Waveform

```bash
gtkwave sdFSM1011.vcd
```

---

## Features

- Mealy FSM implementation
- Detects sequence `1011`
- Supports overlapping pattern detection
- Asynchronous reset
- Positive-edge-triggered operation
- Lightweight and synthesizable design

---

## Applications

- Serial data monitoring
- Communication receivers
- Protocol detection
- Digital pattern recognition
- Control systems
- Embedded digital logic

---

## Notes

- Output is asserted for one clock cycle when the sequence is detected.
- Overlapping sequences are supported.
- The FSM uses four states to recognize the pattern.
- Mealy FSM provides faster detection since output depends on both present state and input.

---