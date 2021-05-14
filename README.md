# VHDL-ALU
A simple ALU implementation in VHDL made in "Quartus Pro".

The ALU has 8 operation: 

1. 2's complement of A
2. A + B
3. A - B
4. A * B
5. A^2
6. A and B
7. A or B
8. not A

The code has a structural architecture where each operation has sub-components (subtration has the fulladder and 2's complement compomenent, for example).
Also, the code was implemented on a Cyclone IV FPGA remotely using the platform "Labsland".

Some examples of the ALU working:

- _Power Operation_

![Alt text](potencia.jpg?raw=true "Power Operation")

- _Or Operation_

![Alt text](or.jpg?raw=true "Or Operation")

