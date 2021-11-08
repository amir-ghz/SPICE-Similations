
# HSPICE Simulations

The purpose of these two simple projects is to learn HSPICE simulations for later research for Low Power Systems Design. Both projects are simulated using CMOS technology. 

## Part one: ring oscillator

A ring oscillator is designed and the total voltage source power dissipation is calculated with different device sizes.

the ring oscillator spice simulation results are presented below for comparison purposes with your own simulations.
```
NMOS L=45n W=90n
PMOS L=45 W=360n

  analysis           time    # points   tot. iter  conv.iter
  op point           0.01           1           4
  transient          0.06         201        1182         256 rev=       102
  readin             0.06
  errchk             0.01
  setup              0.02
  output             0.00

  volts      3.3000 
  current  -36.4272p
  power    120.2098p

     total voltage source power dissipation=  120.2098p       watts

******************************************************************************************

NMOS L=45n W=90n
PMOS L=22 W=189n

  analysis           time    # points   tot. iter  conv.iter
  op point           0.01           1           4
  transient          0.05         201        1182         256 rev=       102
  readin             0.05
  errchk             0.01
  setup              0.02
  output             0.00

  volts      3.3000 
  current  -36.8024p
  power    121.4478p

     total voltage source power dissipation=  121.4478p       watts

******************************************************************************************


NMOS L=45n W=90n
PMOS L=11 W=90n

  analysis           time    # points   tot. iter  conv.iter
  op point           0.01           1           4
  transient          0.05         201        1182         256 rev=       102
  readin             0.05
  errchk             0.01
  setup              0.02
  output             0.00

  volts      3.3000 
  current  -36.7595p
  power    121.3064p

     total voltage source power dissipation=  121.3064p       watts


******************************************************************************************

NMOS L=45n W=90n
PMOS L=11u W=90u

  analysis           time    # points   tot. iter  conv.iter
  op point           0.01           1           6
  transient          0.04         201         264          76 rev=        15
  readin             0.05
  errchk             0.01
  setup              0.02
  output             0.00

  volts      3.3000 
  current   -2.1804m
  power      7.1954m

     total voltage source power dissipation=    7.1954m       watts
```
## Part two: power dissipation evaluation

The below function is simulated in HSPICE for the analysis of the worse average power dissipation.

![alt text](https://raw.githubusercontent.com/amir-ghz/SPICE-Similations/main/schematic.png)

 - First, the SPICE code looks like this:

 ```
 .include 'nmos.pm'
.include 'pmos.pm'
.MODEL NMOS1 nmos LEVEL=54
.MODEL PMOS1 pmos LEVEL=54
VCC 5 0 5V
VsupplyA 6 0 5v pulse ( 5v 0 0ns 0.4ns 0.4ns 40ns 80ns )
VsupplyB 8 0 5v pulse ( 5v 0 0ns 0.2ns 0.2ns 20ns 40ns )
VsupplyC 10 0 5v pulse ( 5v 0 0ns 0.1ns 0.1ns 10ns 20ns )
VsupplyD 12 0 5v pulse ( 5v 0 0ns 0.05ns 0.05ns 5ns 10ns )
MA 3 6 5 5 PMOS1 L=45n W=90n
MB 4 8 5 5 PMOS1 L=45n W=90n
MC 4 10 5 5 PMOS1 L=45n W=90n
MD 3 12 4 5 PMOS1 L=45n W=90n
MBN 3 9 2 0 NMOS1 L=45n W=45n
MCN 2 11 1 0 NMOS1 L=45n W=45n
MDN 3 13 1 0 NMOS1 L=45n W=45n
MAN 1 7 0 0 NMOS1 L=45n W=45n
C2 3 0 0.5p
M1 7 6 0 0 NMOS1 L=45n W=45n
M2 7 6 5 5 PMOS1 L=45n W=90n
M3 9 8 0 0 NMOS1 L=45n W=45n
M4 9 8 5 5 PMOS1 L=45n W=90n
M5 11 10 0 0 NMOS1 L=45n W=45n
M6 11 10 5 5 PMOS1 L=45n W=90n
M7 13 12 0 0 NMOS1 L=45n W=45n
M8 13 12 5 5 PMOS1 L=45n W=90n
.OP
.TRAN 0.5ns 100ns
.PLOT TRAN v(1) v(2) v(3) v(4) v(5) v(6) v(7)
.PRINT TRAN v(1) v(2) v(3) v(4) v(5) v(6) v(7)
.END
```
See below results as the inverter output voltage is lower than expected:

![alt text](https://raw.githubusercontent.com/amir-ghz/SPICE-Similations/main/1.png)

 - In order to have a high acceptable voltage as the inverter output, we distributed distictive voltage supplys for the not gates as well; therefore, we need to modify our code like this:

 ``` 
 .include 'nmos.pm'
.include 'pmos.pm'
.MODEL NMOS1 nmos LEVEL=54
.MODEL PMOS1 pmos LEVEL=54
VCC 5 0 5V
VsupplyA 6 0 5v pulse ( 5v 0 0ns 0.4ns 0.4ns 40ns 80ns )
VsupplyB 8 0 5v pulse ( 5v 0 0ns 0.2ns 0.2ns 20ns 40ns )
VsupplyC 10 0 5v pulse ( 5v 0 0ns 0.1ns 0.1ns 10ns 20ns )
VsupplyD 12 0 5v pulse ( 5v 0 0ns 0.05ns 0.05ns 5ns 10ns )
VsupplyANOT 7 0 5 pulse ( 0 5v 1ns 0.4ns 0.4ns 40ns 80ns )
VsupplyBNOT 9 0 5v pulse ( 0 5v 0ns 0.2ns 0.2ns 20ns 40ns )
VsupplyCNOT 11 0 5v pulse ( 0 5v 0ns 0.1ns 0.1ns 10ns 20ns )
VsupplyDNOT 13 0 5v pulse ( 0 5v 0ns 0.05ns 0.05ns 5ns 10ns )
MA 3 6 5 5 PMOS1 L=45n W=90n
MB 4 8 5 5 PMOS1 L=45n W=90n
MC 4 10 5 5 PMOS1 L=45n W=90n
MD 3 12 4 5 PMOS1 L=45n W=90n
MBN 3 9 2 0 NMOS1 L=45n W=45n
MCN 2 11 1 0 NMOS1 L=45n W=45n
MDN 3 13 1 0 NMOS1 L=45n W=45n
MAN 1 7 0 0 NMOS1 L=45n W=45n
C2 3 0 0.5p
.OP
.TRAN 0.5ns 100ns
.PLOT TRAN v(1) v(2) v(3) v(4) v(5) v(6) v(7)
.PRINT TRAN v(1) v(2) v(3) v(4) v(5) v(6) v(7)
.END
```

And this is the result for the inverter output voltage after simulation:

![alt text](https://raw.githubusercontent.com/amir-ghz/SPICE-Similations/main/2.png)

 - Finally, we want to find which of the input combinations will lead to the worse average power consumption. Here is the result for every possible input with its average power consumption.

![alt text](https://raw.githubusercontent.com/amir-ghz/SPICE-Similations/main/result.PNG)

