# 🔄 Logical Operations with Pipelining (Verilog)

This project implements a pipelined logic processing unit in Verilog that takes a 32-bit free-running counter and performs two logical operations across two and three pipeline stages respectively.

---

## 📘 Problem Statement

Design a pipelined logic processing unit that:
- Takes a 32-bit counter `{D, C, B, A}` as input  
  where:
  - `A = counter[7:0]`
  - `B = counter[15:8]`
  - `C = counter[23:16]`
  - `D = counter[31:24]`
  
- Performs the following operations:
  - **E = A | (B & C)** — computed in 2 clock cycles  
  - **F = (B & C) ^ (A | D)** — computed in 3 clock cycles  

- Asserts `valid_out` when `E == F`  
- Counts how many times `E == F` using `EF_match_count`

---

## 🧠 Design Objective

- Maintain **pipeline correctness** (E and F must originate from the same input snapshot)  
- Use **pipeline registers** to separate stages  
- No logic shortcutting allowed  

---

## 🧩 Module: `pipelining.v`

### 🔷 Inputs:
- `i_clk` – Clock signal  
- `i_rst` – Active-high synchronous reset  
- `counter[31:0]` – Free-running 32-bit counter input  

### 🔷 Outputs:
- `valid_out` – High when `E == F`  
- `EF_match_count[31:0]` – Counter for matching events  

---

## 🔄 Pipeline Stages

### ▶️ Stage 1
- Latches A, B, C, D from input counter  

### ▶️ Stage 2
- Computes `E = A | (B & C)`  
- Prepares values for F calculation (stores A, D, B & C)  

### ▶️ Stage 3
- Computes `F = (B & C) ^ (A | D)`  
- Compares E and F  
- Updates `valid_out` and increments `EF_match_count` on match  

---

## 📊 Output Behavior

- `valid_out` is asserted (1) only when:  
  ```
  (A | (B & C)) == ((B & C) ^ (A | D))
  ```
- `EF_match_count` increments on every such match  

---

## 🖼️ RTL Design Diagram

![RTL Design Diagram](https://github.com/obulsai/bitwise-pipeline-unit-/blob/fab0c83bbc4299e0e763e33187b1d7cfe2b3884a/RTL%20design/RTL%20DESIGN.png?raw=true)

---

## 🧪 Simulation Output

The waveform below shows how `valid_out` goes high when the pipelined values of E and F match:

![Simulation Waveform](https://github.com/obulsai/bitwise-pipeline-unit-/blob/fab0c83bbc4299e0e763e33187b1d7cfe2b3884a/Simulation/Simulation_1.png?raw=true)

---

## 📁 File Structure

```plaintext
bitwise-pipeline-unit-/
├── pipelining.v               # 3-stage pipelined logic module
├── RTL design/
│   └── RTL DESIGN.png         # Pipeline architecture diagram
├── Simulation/
│   └── Simulation_1.png       # Functional waveform output
├── README.md                  # Project documentation
```

---

## 👨‍💻 Author

**T. Obul Sai**  
B.Tech 3rd Year, ECE  
RGUKT RK Valley  
📧 Email: obulsai187@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/obul-sai-922643251)
