v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 40 -25 40 -15 { lab=GND}
N 95 -95 95 -85 { lab=VBODY1}
N 160 -95 160 -85 { lab=VBODY2}
N 225 -95 225 -85 { lab=VBODY3}
N 290 -95 290 -85 { lab=VBODY4}
N 355 -95 355 -85 { lab=VBODY5}
N 95 -25 95 -15 { lab=GND}
N 95 -25 160 -25 { lab=GND}
N 160 -25 225 -25 { lab=GND}
N 225 -25 290 -25 { lab=GND}
N 290 -25 355 -25 { lab=GND}
N 565 -100 660 -100 { lab=VOUT0}
N 660 -100 660 -90 { lab=VOUT0}
N 660 -30 660 -20 { lab=GND}
N 490 -100 500 -100 { lab=VIN}
N 40 -95 40 -85 { lab=VIN}
N 530 -75 530 -65 { lab=GND}
N 565 -275 660 -275 { lab=VOUT1}
N 660 -275 660 -265 { lab=VOUT1}
N 660 -205 660 -195 { lab=GND}
N 490 -275 500 -275 { lab=VIN}
N 530 -250 530 -240 { lab=VBODY1}
N 565 -450 660 -450 { lab=VOUT2}
N 660 -450 660 -440 { lab=VOUT2}
N 660 -380 660 -370 { lab=GND}
N 490 -450 500 -450 { lab=VIN}
N 530 -425 530 -415 { lab=VBODY2}
N 565 -625 660 -625 { lab=VOUT3}
N 660 -625 660 -615 { lab=VOUT3}
N 660 -555 660 -545 { lab=GND}
N 490 -625 500 -625 { lab=VIN}
N 530 -600 530 -590 { lab=VBODY3}
N 565 -795 660 -795 { lab=VOUT4}
N 660 -795 660 -785 { lab=VOUT4}
N 660 -725 660 -715 { lab=GND}
N 490 -795 500 -795 { lab=VIN}
N 530 -770 530 -760 { lab=VBODY4}
N 565 -965 660 -965 { lab=VOUT5}
N 660 -965 660 -955 { lab=VOUT5}
N 660 -895 660 -885 { lab=GND}
N 490 -965 500 -965 { lab=VIN}
N 530 -940 530 -930 { lab=VBODY5}
C {devices/gnd.sym} 40 -15 0 0 {name=l1 lab=GND}
C {devices/code_shown.sym} 40 -475 0 0 {name=NGSPICE
only_toplevel=true
value="
.control
dc V1 -1.8 1.8 1m
*** tran 10p 1u
plot VIN VOUT0 VOUT1 VOUT2 VOUT3 VOUT4 VOUT5
write tb_wisp_diode_nfet_lvt.raw
.endc
" }
C {devices/code.sym} 35 -300 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".lib \\\\$::SKYWATER_MODELS\\\\/sky130.lib.spice tt

.param mc_mm_switch=0
.param mc_pr_switch=1

"}
C {devices/vsource.sym} 40 -55 0 0 {name=V1 value=1.8}
C {wisp_diode_nfet_lvt.sym} 525 -100 0 0 {name=X1 m=1
+ W_N=1 L_N=0.15}
C {devices/res.sym} 660 -60 0 0 {name=R1
value=500k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 490 -100 0 0 {name=l2 sig_type=std_logic lab=VIN}
C {devices/vsource.sym} 95 -55 0 0 {name=V2 value=100m}
C {devices/vsource.sym} 160 -55 0 0 {name=V3 value=200m}
C {devices/vsource.sym} 225 -55 0 0 {name=V4 value=500m}
C {devices/vsource.sym} 290 -55 0 0 {name=V5 value=900m}
C {devices/vsource.sym} 355 -55 0 0 {name=V6 value=1.8}
C {devices/gnd.sym} 95 -15 0 0 {name=l7 lab=GND}
C {devices/lab_pin.sym} 95 -95 1 0 {name=l4 sig_type=std_logic lab=VBODY1}
C {devices/lab_pin.sym} 160 -95 1 0 {name=l5 sig_type=std_logic lab=VBODY2}
C {devices/lab_pin.sym} 225 -95 1 0 {name=l6 sig_type=std_logic lab=VBODY3}
C {devices/lab_pin.sym} 290 -95 1 0 {name=l8 sig_type=std_logic lab=VBODY4}
C {devices/lab_pin.sym} 355 -95 1 0 {name=l9 sig_type=std_logic lab=VBODY5}
C {devices/gnd.sym} 660 -20 0 0 {name=l3 lab=GND}
C {devices/lab_pin.sym} 40 -95 1 0 {name=l10 sig_type=std_logic lab=VIN}
C {devices/lab_pin.sym} 660 -100 1 0 {name=l11 sig_type=std_logic lab=VOUT0}
C {devices/gnd.sym} 530 -65 0 0 {name=l12 lab=GND}
C {wisp_diode_nfet_lvt.sym} 525 -275 0 0 {name=X2 m=1
+ W_N=1 L_N=0.15}
C {devices/res.sym} 660 -235 0 0 {name=R2
value=500k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 490 -275 0 0 {name=l13 sig_type=std_logic lab=VIN}
C {devices/gnd.sym} 660 -195 0 0 {name=l14 lab=GND}
C {devices/lab_pin.sym} 660 -275 1 0 {name=l15 sig_type=std_logic lab=VOUT1}
C {devices/lab_pin.sym} 530 -240 3 0 {name=l16 sig_type=std_logic lab=VBODY1}
C {wisp_diode_nfet_lvt.sym} 525 -450 0 0 {name=X3 m=1
+ W_N=1 L_N=0.15}
C {devices/res.sym} 660 -410 0 0 {name=R3
value=500k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 490 -450 0 0 {name=l17 sig_type=std_logic lab=VIN}
C {devices/gnd.sym} 660 -370 0 0 {name=l18 lab=GND}
C {devices/lab_pin.sym} 660 -450 1 0 {name=l19 sig_type=std_logic lab=VOUT2}
C {devices/lab_pin.sym} 530 -415 3 0 {name=l20 sig_type=std_logic lab=VBODY2}
C {wisp_diode_nfet_lvt.sym} 525 -625 0 0 {name=X4 m=1
+ W_N=1 L_N=0.15}
C {devices/res.sym} 660 -585 0 0 {name=R4
value=500k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 490 -625 0 0 {name=l21 sig_type=std_logic lab=VIN}
C {devices/gnd.sym} 660 -545 0 0 {name=l22 lab=GND}
C {devices/lab_pin.sym} 660 -625 1 0 {name=l23 sig_type=std_logic lab=VOUT3}
C {devices/lab_pin.sym} 530 -590 3 0 {name=l24 sig_type=std_logic lab=VBODY3}
C {wisp_diode_nfet_lvt.sym} 525 -795 0 0 {name=X5 m=1
+ W_N=1 L_N=0.15}
C {devices/res.sym} 660 -755 0 0 {name=R5
value=500k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 490 -795 0 0 {name=l25 sig_type=std_logic lab=VIN}
C {devices/gnd.sym} 660 -715 0 0 {name=l26 lab=GND}
C {devices/lab_pin.sym} 660 -795 1 0 {name=l27 sig_type=std_logic lab=VOUT4}
C {devices/lab_pin.sym} 530 -760 3 0 {name=l28 sig_type=std_logic lab=VBODY4}
C {wisp_diode_nfet_lvt.sym} 525 -965 0 0 {name=X6 m=1
+ W_N=1 L_N=0.15}
C {devices/res.sym} 660 -925 0 0 {name=R6
value=500k
footprint=1206
device=resistor
m=1}
C {devices/lab_pin.sym} 490 -965 0 0 {name=l29 sig_type=std_logic lab=VIN}
C {devices/gnd.sym} 660 -885 0 0 {name=l30 lab=GND}
C {devices/lab_pin.sym} 660 -965 1 0 {name=l31 sig_type=std_logic lab=VOUT5}
C {devices/lab_pin.sym} 530 -930 3 0 {name=l32 sig_type=std_logic lab=VBODY5}
