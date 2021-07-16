v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 1760 -910 1790 -910 { lab=A}
N 1850 -910 1880 -910 { lab=Y}
N 1820 -910 1820 -860 { lab=BODY}
N 1790 -950 1790 -910 { lab=A}
N 1790 -950 1820 -950 { lab=A}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 1820 -930 3 1 {name=M1
L=0.15
W=1
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8_lvt
spiceprefix=X
}
C {devices/ipin.sym} 1770 -910 0 0 {name=p1 lab=A}
C {devices/iopin.sym} 1820 -870 1 0 {name=p2 lab=BODY}
C {devices/opin.sym} 1870 -910 0 0 {name=p3 lab=Y}
C {devices/lab_pin.sym} 1820 -880 0 0 {name=l1 sig_type=std_logic lab=BODY}
