# Verilog Full Adder Design & FPGA Implementation

## Project Overview
A complete, synthesizable 1-bit full adder module implemented using dataflow modeling in Verilog HDL. Verified via behavioral simulation and implemented on the **AMD/Xilinx Artix-7 FPGA (`xc7a35tcpg236-1` / Basys 3)** with full bitstream generation.

---

## Quick Start

### Prerequisites
- Xilinx Vivado Design Suite (2018.1 or later recommended; verified on Vivado 2024.2)
- Target FPGA: AMD/Xilinx Artix-7 (`xc7a35tcpg236-1` / Digilent Basys 3)
- Basic understanding of Verilog HDL & digital logic
- Git (for cloning the repository)

### Installation & Setup

```bash
# Clone the repository
git clone [https://github.com/technoas123/Verilog-Full-Adder.git](https://github.com/technoas123/Verilog-Full-Adder.git)
cd Verilog-Full-Adder

# Open the project in Vivado
vivado full_adder.xpr

```

---

## Detailed Design Analysis

### 1. Hardware Implementation (RTL)

**File:** `full_adder.srcs/sources_1/new/full_adder.v`

```verilog
`timescale 1ns / 1ps

module full_adder(
    input  wire a, b, cin,
    output wire sum, carry
);
    
    // Dataflow modeling using continuous assignments
    assign sum   = a ^ b ^ cin;                        // Sum = XOR of all three inputs
    assign carry = (a & b) | (b & cin) | (cin & a);    // Majority function (Carry out)
    
endmodule

```

**Key Features:**

* **Dataflow Modeling**: Concurrent logic mapping using continuous `assign` statements.
* **Synthesizable**: Maps efficiently to standard FPGA Look-Up Tables (LUTs).

---

### 2. Physical Pin Constraints (`.xdc`)

**File:** `full_adder.srcs/constrs_1/new/full_adder_pins.xdc`

To target the Digilent Basys 3 (`xc7a35tcpg236-1`) board, the physical slide switches and LEDs are mapped as follows:

```xdc
## Inputs (Slide Switches: SW0, SW1, SW2)
set_property PACKAGE_PIN V17 [get_ports a]
set_property IOSTANDARD LVCMOS33 [get_ports a]

set_property PACKAGE_PIN V16 [get_ports b]
set_property IOSTANDARD LVCMOS33 [get_ports b]

set_property PACKAGE_PIN W16 [get_ports cin]
set_property IOSTANDARD LVCMOS33 [get_ports cin]

## Outputs (LEDs: LD0, LD1)
set_property PACKAGE_PIN U16 [get_ports sum]
set_property IOSTANDARD LVCMOS33 [get_ports sum]

set_property PACKAGE_PIN E19 [get_ports carry]
set_property IOSTANDARD LVCMOS33 [get_ports carry]

```

#### FPGA Hardware Mapping Reference

| Port Name | Direction | Board Component | Package Pin | I/O Standard |
| --- | --- | --- | --- | --- |
| `a` | Input | Slide Switch `SW0` | `V17` | `LVCMOS33` (3.3V) |
| `b` | Input | Slide Switch `SW1` | `V16` | `LVCMOS33` (3.3V) |
| `cin` | Input | Slide Switch `SW2` | `W16` | `LVCMOS33` (3.3V) |
| `sum` | Output | LED `LD0` | `U16` | `LVCMOS33` (3.3V) |
| `carry` | Output | LED `LD1` | `E19` | `LVCMOS33` (3.3V) |

---

### 3. Testbench Design

**File:** `full_adder.srcs/sim_1/new/tb_full_adder.v`

```verilog
`timescale 1ns / 1ps

module tb_full_adder;

    // Testbench signals
    reg a, b, cin;
    wire sum, carry;

    // Device Under Test (DUT)
    full_adder dut (
        .a(a), .b(b), .cin(cin),
        .sum(sum), .carry(carry)
    );

    initial begin
        // Monitor signals with timestamps
        $monitor("Time = %0t | a = %b, b = %b, cin = %b | sum = %b, carry = %b", 
                 $time, a, b, cin, sum, carry);
        
        // Test all 8 possible input combinations
        {a, b, cin} = 3'b000; #10;
        {a, b, cin} = 3'b001; #10;
        {a, b, cin} = 3'b010; #10;
        {a, b, cin} = 3'b011; #10;
        {a, b, cin} = 3'b100; #10;
        {a, b, cin} = 3'b101; #10;
        {a, b, cin} = 3'b110; #10;
        {a, b, cin} = 3'b111; #10;
        
        $stop; // End simulation
    end

endmodule

```

---

## Simulation & Waveform Verification

### Expected Simulation Results

| Time (ns) | a | b | cin | sum | carry | Operation |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | 0 | 0 | 0 | 0 | 0 | 0 + 0 + 0 = 0 |
| 10 | 0 | 0 | 1 | 1 | 0 | 0 + 0 + 1 = 1 |
| 20 | 0 | 1 | 0 | 1 | 0 | 0 + 1 + 0 = 1 |
| 30 | 0 | 1 | 1 | 0 | 1 | 0 + 1 + 1 = 2 (binary 10) |
| 40 | 1 | 0 | 0 | 1 | 0 | 1 + 0 + 0 = 1 |
| 50 | 1 | 0 | 1 | 0 | 1 | 1 + 0 + 1 = 2 |
| 60 | 1 | 1 | 0 | 0 | 1 | 1 + 1 + 0 = 2 |
| 70 | 1 | 1 | 1 | 1 | 1 | 1 + 1 + 1 = 3 (binary 11) |

---

## Synthesis, Implementation & Bitstream Generation

### Resource Utilization (`xc7a35tcpg236-1`)

| Resource | Used | Available | Utilization % |
| --- | --- | --- | --- |
| **LUT as Logic** | 2 | 20,800 | < 1% |
| **Bonded IOB** | 5 | 106 | ~4.7% |
| **CLB Slices** | 1 | 8,150 | < 1% |

---

### Step-by-Step Hardware Flow in Vivado

#### Option 1: GUI Flow

1. **Run Synthesis:** Click **Run Synthesis** in the left Flow Navigator.
2. **Run Implementation:** Click **Run Implementation** to place and route the LUTs to package pins.
3. **Generate Bitstream:** Click **Generate Bitstream** (under *Program and Debug*).
4. **Program Hardware:**
* Connect the FPGA board via USB.
* Click **Open Hardware Manager** → **Open Target** → **Auto Connect**.
* Click **Program Device** and select `full_adder.bit`.



#### Option 2: Tcl Console Flow

```tcl
# 1. Synthesize logic
synth_design -top full_adder -part xc7a35tcpg236-1

# 2. Optimize, Place and Route
opt_design
place_design
route_design

# 3. Write Bitstream
write_bitstream -force full_adder.bit

```

### Generated Bitstream Artifact

The compiled FPGA bitstream is generated at:

```text
full_adder.runs/impl_1/full_adder.bit

```

---

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

Distributed under the [MIT License](https://www.google.com/search?q=LICENSE).

---

## Contact & Support

* **Maintainer:** Ahammed Salahuddeen N Y
* **Email:** ahammedsalahuddeenaffiliate@gmail.com
* **Issues:** [GitHub Issues](https://www.google.com/search?q=https://github.com/technoas123/Verilog-Full-Adder/issues)
