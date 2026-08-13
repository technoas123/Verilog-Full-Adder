# Verilog Full Adder Design & Simulation

## Project Overview
A synthesizable 1-bit full adder module implemented using dataflow modeling in Verilog HDL and verified via behavioral simulation in Xilinx Vivado.

## Quick Start

### Prerequisites
- Xilinx Vivado Design Suite (2018.1 or later recommended)
- Basic understanding of Verilog HDL
- Git (for cloning the repository)

### Installation & Setup

```bash
# Clone the repository
git clone https://github.com/technoas123/Verilog-Full-Adder.git
cd verilog-full-adder

# Open the project in Vivado
vivado full_adder.xpr
```

## Detailed Design Analysis

### 1. Hardware Implementation

**File:** `full_adder.srcs/sources_1/new/full_adder.v`

```verilog
`timescale 1ns / 1ps

module full_adder(
    input a, b, cin,
    output sum, carry
    );
    
    // Dataflow modeling using continuous assignments
    assign sum = a ^ b ^ cin;      // Sum = XOR of all three inputs
    assign carry = (a & b) | (b & cin) | (cin & a);  // Majority function
    
endmodule
```

**Key Features:**
- **Dataflow Modeling**: Uses `assign` statements for concurrent execution
- **Gate-level implementation**: Direct translation of Boolean equations
- **Synthesizable**: Can be synthesized to real hardware components

### 2. Testbench Design

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
        // Monitor signals with time stamps
        $monitor("Time = %0t ns | a=%b b=%b cin=%b | sum=%b carry=%b", 
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

**Testbench Features:**
- **100% Coverage**: All 8 input combinations tested
- **Monitoring**: Real-time signal tracking via `$monitor`
- **Structured Test**: Sequential stimulus generation

## Expected Simulation Results

| Time (ns) | a | b | cin | sum | carry | Operation |
|-----------|---|---|-----|-----|-------|-----------|
| 0 | 0 | 0 | 0 | 0 | 0 | 0 + 0 + 0 = 0 |
| 10 | 0 | 0 | 1 | 1 | 0 | 0 + 0 + 1 = 1 |
| 20 | 0 | 1 | 0 | 1 | 0 | 0 + 1 + 0 = 1 |
| 30 | 0 | 1 | 1 | 0 | 1 | 0 + 1 + 1 = 2 (binary 10) |
| 40 | 1 | 0 | 0 | 1 | 0 | 1 + 0 + 0 = 1 |
| 50 | 1 | 0 | 1 | 0 | 1 | 1 + 0 + 1 = 2 |
| 60 | 1 | 1 | 0 | 0 | 1 | 1 + 1 + 0 = 2 |
| 70 | 1 | 1 | 1 | 1 | 1 | 1 + 1 + 1 = 3 (binary 11) |

## Running Simulation in Vivado

### Method 1: GUI Interface
1. Open Vivado and navigate to the project
2. In the Sources window, right-click `tb_full_adder.v`
3. Select "Set as Top" (if not already set)
4. In Flow Navigator, click "Run Simulation" → "Run Behavioral Simulation"
5. View results in waveform viewer and Tcl Console

### Method 2: TCL Script
```tcl
# Run behavioral simulation
launch_simulation

# Add signals to waveform
add_force {/tb_full_adder/a} -radix binary
add_force {/tb_full_adder/b} -radix binary
add_force {/tb_full_adder/cin} -radix binary
add_force {/tb_full_adder/sum} -radix binary
add_force {/tb_full_adder/carry} -radix binary

# Run simulation
run all
```

## Synthesis and Implementation

### Synthesis Commands
```tcl
# Synthesis
synth_design -top full_adder -part xc7a35tcpg236-1

# Implementation
opt_design
place_design
route_design

# Generate bitstream (optional)
write_bitstream -force full_adder.bit
```


## Contributing

### How to Contribute
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Contribution Guidelines
- Follow Verilog coding standards (IEEE 1364-2001)
- Include testbench updates for new features
- Update documentation accordingly
- Add comments for complex logic

## License

MIT License - See LICENSE file for details

## Contact & Support

- **Project Maintainer**: Ahammed Salahuddeen N Y 
- **Email**: ahammedsalahuddeenaffiliate@gmail.com
- **GitHub Issues**: [Report Issue](https://github.com/technoas123/Verilog-Full-Adder.git/issues)

## Acknowledgment

This project is created for educational purposes to demonstrate fundamental digital design concepts using industry-standard tools and methodologies.
