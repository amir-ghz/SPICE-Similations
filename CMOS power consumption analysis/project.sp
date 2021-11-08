.include 'nmos.pm'
.include 'pmos.pm'
.MODEL NMOS1 nmos LEVEL=54
.MODEL PMOS1 pmos LEVEL=54

VCC 5 0 5V pulse ( 5v 0 0ns 0.4ns 0.4ns 40ns 80ns )


MA 3 0 5 5 PMOS1 L=45n W=90n
MB 4 0 0 5 PMOS1 L=45n W=90n
MC 4 0 0 5 PMOS1 L=45n W=90n
MD 3 0 0 5 PMOS1 L=45n W=90n


MBN 3 5 2 0 NMOS1 L=45n W=45n
MCN 2 5 1 0 NMOS1 L=45n W=45n
MDN 3 5 1 0 NMOS1 L=45n W=45n
MAN 1 5 0 0 NMOS1 L=45n W=45n


C2 3 0 0.5p

*M1 7 6 0 0 NMOS1 L=45n W=45n
*M2 7 6 5 5 PMOS1 L=45n W=90n

*M3 9 8 0 0 NMOS1 L=45n W=45n
*M4 9 8 5 5 PMOS1 L=45n W=90n

*M5 11 10 0 0 NMOS1 L=45n W=45n
*M6 11 10 5 5 PMOS1 L=45n W=90n

*M7 13 12 0 0 NMOS1 L=45n W=45n
*M8 13 12 5 5 PMOS1 L=45n W=90n


.OP
.TRAN 0.5ns 100ns
.PLOT TRAN v(3) v(5) 
.PRINT TRAN v(3) v(5)
.measure tran power_avg avg power 
.END