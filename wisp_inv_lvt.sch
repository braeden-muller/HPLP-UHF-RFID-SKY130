v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N 1590 -885 1590 -865 { lab=Y}
N 1550 -915 1550 -835 { lab=A}
N 1590 -835 1600 -835 { lab=VN}
N 1600 -835 1600 -805 { lab=VN}
N 1590 -805 1600 -805 { lab=VN}
N 1590 -915 1600 -915 { lab=VP}
N 1600 -945 1600 -915 { lab=VP}
N 1590 -945 1600 -945 { lab=VP}
N 1510 -875 1550 -875 { lab=A}
N 1590 -875 1620 -875 { lab=Y}
N 1590 -805 1590 -765 { lab=VN}
N 1590 -985 1590 -945 { lab=VP}
C {sky130_fd_pr/nfet_01v8_lvt.sym} 1570 -835 0 0 {name=M1
L=L_N
W=W_N
nf=1
mult=1
model=nfet_01v8_lvt
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8_lvt.sym} 1570 -915 0 0 {name=M2
L=L_P
W=W_P
nf=1
mult=1
model=pfet_01v8_lvt
spiceprefix=X
}
C {devices/ipin.sym} 1520 -875 0 0 {name=p1 lab=A}
C {devices/opin.sym} 1620 -875 0 0 {name=p2 lab=Y}
C {devices/title.sym} 1140 -600 0 0 {name=l3 author="Braeden Muller"}
C {devices/iopin.sym} 1580 -765 0 0 {name=p3 lab=VN}
C {devices/iopin.sym} 1580 -985 0 0 {name=p4 lab=VP}
C {devices/lab_pin.sym} 1590 -970 0 0 {name=l1 sig_type=std_logic lab=VP}
C {devices/lab_pin.sym} 1590 -790 0 0 {name=l2 sig_type=std_logic lab=VN}
