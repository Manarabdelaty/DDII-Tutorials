# Tutorial [1]: Iverilog 

## Dependecies

- [Icarus Verilog](http://iverilog.icarus.com/)
- [GTKWave](http://gtkwave.sourceforge.net/)
- [Covered](http://covered.sourceforge.net/)

## Installing

### Linux
  Install iverilog: 
  ``
  sudo apt-get install iverilog
  ``
  
  Install GTKWave: 
  ``
  sudo apt-get install gtkwave
  ``
  
### MacOS

  Install iverilog:
  ``
  brew install icarus-verilog
  ``
  
  Install GTKWave: Check [sourceforge](http://gtkwave.sourceforge.net/)
  
  
## Covered Installation
 
 #### Dependencies
 
  - gcc 
  - flex 
  - bison
  - GNU make
  - GNU gperf
  - tcl (8.5)
  - tcl-devel (8.5)
  - tk (8.5)
  - tk-devel (8.5)
  - tcllib
  
  All linux distributions should come with gcc pre-built, so no need to install it. 
  
  Install flex, bison, make, and gperf.
 
  ```
  sudo apt-get update 
  sudo apt-get install flex
  sudo apt-get install bison
  sudo apt-get install gperf
  sudo apt-get install build-essential
  ```
  
  Note: Higher version of tcl packages depecrated some of the code used in covered source code, so you will need to downgrade the tcl packages to 8.5 if they already exist in your system or explicity install the 8.5 version as follows: 
  
  ``
   sudo apt-get install tcl8.5 tk8.5 tcl8.5-dev tk8.5-dev tcllib
  ``
  
  ### Build Covered Source Code
  
  First, clone covered [repo](https://github.com/Manarabdelaty/verilog-covered) . 
  
  ``
  git clone https://github.com/Manarabdelaty/verilog-covered
  ``
  
  Then go to covered repo by invoking
  
  ``
  cd verilog-covered
  ``
  
  Configure the build by invoking
  
  ``
  ./configure
  ``
  
  Build and compile the source code by typing: 
  
  ``
  make
  ``
  
  Install the generated executable from the make process by typing: 
  
  ``
  make install
  ``
  
## Usage
  
### Iverilog

1) Before working with iverilog workflow, you need to specify the path to the output vcd file and the dump level. This is done by using (in the testbench module) the following system tasks:
 
  ```
  $dumpfile(“<path-to-your-vcd-file>”);
  $dumpvars(<dump-level>, <module-name>);
  ```

  For example, the following dumps all variables inside the testbench and the modules instantiated in a file called ``dut.vcd``

  ```
  $dumpfile(“dut.vcd”);
  $dumpvars(0, RippleCarryAdder_tb);
  ```

2) Compile your RTL module and testbench into what is called vvp assembly file using iverilog command

  ```
  iverilog <RTL-file> <Testbench-file> -o <vvp-file>
  ```

  Ex: ``iverilog rippleCarryAdder.v rippleCarryAdder_tb.v -o rca.vvp``

3) Call the vvp engine to run the simulation.

  ```
  vvp <vvp-file>
  ```

  Ex: ``vvp rca.vvp``

3) View the waveform using the GTKwave application

  ```
  gtkwave <vcd-file>
  ```

  Ex: ``gtkwave rca.vcd``

  This will open the grkwave app. You can add signals to the view by selecting them and clicking on the ``append`` button.
  
  To view the whole simulation time, press zoom fit from the top toolbar

### Covered

Generating covered reports is done on two steps. 

1) First invoke the score command as follows: 

  ```
  covered score -t <tb-top-module> -v <testbench-file> -v <module-file> -vcd <dumped-vcd-file> -o <cdd-output-file-name>
  ```

  Ex: 

  ```
  covered score -t RippleCarryAdder_tb -v dut_tb.v -v dut.v -vcd dut.vcd -o top.cdd
  ```

2) Then invoke the report command: 

  ```
  covered report <cdd-file-name>
  ```

  Ex: 

  ```
  covered report top.cdd
  ```

 
