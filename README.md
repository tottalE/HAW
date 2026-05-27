# Lab Exercise 2 (Part 3) - Boolean Logic Module

## 📌 Project Overview
* **Course:** HAW Hamburg [IE03-DIL]
* **Module Name:** `boolean_logic`
* **File Name:** `boolean_logic.vhd`
* **Description:** This module implements specific boolean logic operations using VHDL processes and variables, processing multi-bit input signals into designated outputs.

---

## 🔌 Port Definitions

| Port Name | Direction | Data Type | Description |
| :--- | :---: | :---: | :--- |
| `din0` | In | `std_logic_vector(1 downto 0)` | 2-bit Input data |
| `din1` | In | `std_logic_vector(3 downto 0)` | 4-bit Input data |
| `dout0` | Out | `std_logic_vector(1 downto 0)` | 2-bit Output data (Derived from internal logic) |
| `dout1` | Out | `std_logic_vector(2 downto 0)` | 3-bit Output data (Mixed bit assignment) |
| `dout2` | Out | `std_logic` | 1-bit Output data (Inverted bit) |

---

## 🛠️ Internal Logic & Functional Description

The module utilizes a combinatorial process with sequential internal variables (`variable`) to compute the outputs immediately when any input changes.

### 1. Internal Variables Assignment
The logic equations solved inside the process are as follows:
* `var1_v` = $din0(0) \cdot din0(1) \cdot din1(0)$
* `var2_v` = $\overline{din1(0)}$
* `var3_v` = $din1(0) \odot din1(3)$ (XNOR)
* `var4_v` = $\overline{var1\_v + var2\_v}$ (NOR)
* `var5_v` = $din1(0) \cdot var3\_v$
* `var6_v` = $\overline{din1(2)}$

### 2. Output Mapping
The calculated variables and raw inputs are mapped to the final output ports as follows:

* **`dout0` (2-bit):**
  * `dout0(0)` = `var4_v`
  * `dout0(1)` = `var5_v`
* **`dout1` (3-bit):**
  * `dout1(0)` = `var5_v`
  * `dout1(1)` = `din1(1)`
  * `dout1(2)` = `din1(3)`
* **`dout2` (1-bit):**
  * `dout2` = `var6_v`

---

## 💻 How to Simulate / Synthesize
1. Add `boolean_logic.vhd` to your AMD Vivado project.
2. Ensure the syntax is correct and run **RTL Analysis** to verify the schematic.
3. Use a testbench to apply various stimuli to `din0` and `din1` to verify the outputs match the expected boolean truth tables.