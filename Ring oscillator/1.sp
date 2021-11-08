Simple cmos inverter
* CMOS Inverter
.include 'nmos.pm'
.include 'pmos.pm'
.MODEL NMOS1 nmos
.MODEL PMOS1 pmos
*.SUBCKT inverter vdd input output
*M1 output input vdd vdd PMOS1
*M2 output input 0 0 NMOS1
*C1 output 0 0.05p
*.END inverter
*X1 3 1 2 inverter
M1 2 1 3 3 PMOS1 l=45n w=450n
M2 2 1 0 0 NMOS1 l=45n w=45n
C1 2 0 0.05
VCC 3 0 1V
VIN 1 0 0V pulse ( 1 0 1ns 1ns 1ns 40ns 80ns)
.OP
.TRAN 0.5ns 100ns
.PLOT TRAN v(1) v(2)
.PRINT TRAN v(1) v(2)
.END    