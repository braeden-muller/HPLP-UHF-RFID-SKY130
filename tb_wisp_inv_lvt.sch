v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 1420 -920 1460 -920 { lab=VSIGNAL}
N 1420 -860 1420 -840 { lab=GND}
N 1670 -920 1670 -910 { lab=VOUT_2}
N 1620 -920 1670 -920 { lab=VOUT_2}
N 1670 -850 1670 -840 { lab=GND}
N 1365 -785 1365 -770 { lab=VDATA}
N 1365 -710 1365 -700 { lab=GND}
N 1240 -785 1240 -770 { lab=VCARRIER}
N 1240 -710 1240 -700 { lab=GND}
N 1360 -840 1360 -830 { lab=GND}
N 1360 -840 1420 -840 { lab=GND}
N 1420 -840 1490 -840 { lab=GND}
N 1490 -895 1490 -840 { lab=GND}
N 1490 -975 1490 -945 { lab=VDD}
N 1360 -865 1360 -840 { lab=GND}
N 1360 -945 1360 -920 { lab=VDD}
N 1360 -945 1390 -975 { lab=VDD}
N 1390 -975 1490 -975 { lab=VDD}
N 1555 -975 1585 -945 { lab=VDD}
N 1585 -895 1585 -840 { lab=GND}
N 1525 -920 1555 -920 { lab=VOUT}
N 1490 -975 1555 -975 { lab=VDD}
N 1490 -840 1585 -840 { lab=GND}
N 1585 -840 1670 -840 { lab=GND}
C {devices/gnd.sym} 1360 -830 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} 1360 -890 0 0 {name=V1 value=1.8}
C {devices/code_shown.sym} 1150 -1145 0 0 {name=NGSPICE
only_toplevel=true
value="
.control
*** dc E1 0 1.8 1m
tran 10p 1u
plot VDATA VOUT VOUT_2
write ring_osc.raw
.endc
" }
C {devices/code.sym} 1150 -950 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval( @value )"
value=".lib \\\\$::SKYWATER_MODELS\\\\/sky130.lib.spice tt

.param mc_mm_switch=0
.param mc_pr_switch=1

"}
C {wisp_inv_lvt.sym} 1460 -895 0 0 {name=X1 m=1
+ W_N=1 L_N=0.35 W_P=3.5 L_P=0.35}
C {devices/capa.sym} 1670 -880 0 0 {name=C2
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {devices/vsource_arith.sym} 1420 -890 0 0 {name=E1 VOL="V(VDATA)"}
C {devices/lab_pin.sym} 1365 -785 0 0 {name=l6 sig_type=std_logic lab=VDATA}
C {devices/gnd.sym} 1365 -700 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} 1240 -740 0 0 {name=V3 value="SIN(0 1 915e6)"}
C {devices/gnd.sym} 1240 -700 0 0 {name=l8 lab=GND}
C {devices/lab_pin.sym} 1240 -785 0 0 {name=l9 sig_type=std_logic lab=VCARRIER}
C {devices/vsource.sym} 1365 -740 0 0 {name=V2 value="PULSE(0.18 1.8 0 15n 15n 140n 280n 0)"}
C {wisp_inv_lvt.sym} 1555 -895 0 0 {name=X2 m=1
+ W_N=1 L_N=0.35 W_P=3.5 L_P=0.35}
C {devices/lab_pin.sym} 1540 -920 1 0 {name=l2 sig_type=std_logic lab=VOUT}
C {devices/lab_pin.sym} 1645 -920 1 0 {name=l3 sig_type=std_logic lab=VOUT_2}
C {devices/lab_pin.sym} 1440 -920 1 0 {name=l4 sig_type=std_logic lab=VSIGNAL}
C {devices/lab_pin.sym} 1390 -975 1 0 {name=l5 sig_type=std_logic lab=VDD}
