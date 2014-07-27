#set terminal postscript portrait enhanced "times" 12
set term tikz standalone color size 5in,5in
set ylabel '$\dot{P}$ (s s$^{-1}$)'
set xlabel '$P$ (s)'
set yrange [1E-18:]
set xrange [1E-2:20]

set angle radians

#set output 'p-pdot.ps'
set output 'p-pdot.tex'

set logscale x
set logscale y

set style fill pattern 2 border
set style data points

set format y '10$^{%T}$'
set mxtics 10
set mytics 10

set size 1,0.80901699437

set dummy x

set key bottom right box width 2 height 1 spacing 2
set label '$10^{3}$yr' at 0.015,5E-13
set label '$10^{5}$yr' at 0.015,5E-15
set label '$10^{7}$yr' at 0.015,5E-17
set label '$10^{14}$G' at 0.1,1E-10
set label '$10^{13}$G' at 0.015,5E-12
set label '$10^{12}$G' at 0.015,5E-14

set style line 1 lt 7 lw 1 pt 7 ps 0.3 lc rgb '#240000'
set style line 2 lt 10 lw 1 pt 11 ps 2.0 lc rgb '#32CD32'
set style line 3 lt 1 lw 1 pt 13 ps 1.5 lc rgb '#0000FF'
set style line 4 lt 1 lw 1 pt 5 ps 1.1 lc rgb '#FF0000'
set style line 5 lt 1 lw 1 pt 0 ps 0.5 lc 5
set style line 6 lt 1 lw 0.6 pt 0 ps 0.5 lc 4
set style line 8 lt 1 lw 1 pt 0 ps 0.5 lc 7
set style line 9 lt 1 lw 1 pt 0 ps 0.5 lc 8
set style line 7 lt 1 lw 1 pt 9 ps 1.3 lc rgb '#FF8C00'
set style line 10 lt 1 lw 2 pt 110 ps 1.5 lc rgb '#FF00FF'

a1 = 45*pi/180
s1 = 1 + (sin(a1))**2
ang1 = (sin(a1)*cos(a1))/a1
a2 = 70*pi/180
s2 = 1 + (sin(a2))**2
ang2 = (sin(a2)*cos(a2))/a2
adot = 0.62*(pi/180)/3.15E9
sc = 3.16E7
s = (sin(pi/2))**2
c = 3E10            # cm/s
k = 2*s/(3*c**3)
r3 = 1E18           # cm**3
I = 1E45
mu_c = 5E12*r3
a1_1(x) = adot*x/a1
a2_1(x) = adot*x/a2
muco(x) = ((mu_c*2*pi)**2)/(I*x*c**3)

pdot3(x) = x/(sc*2E3)
pdot5(x) = x/(sc*2E5)
pdot7(x) = x/(sc*2E7)
pdot9(x) = x/(sc*2E9)
mu12(x) = k*(r3*1E12*2*pi)**2/(x*I)
mu13(x) = k*(r3*1E13*2*pi)**2/(x*I)
mu14(x) = k*(r3*1E14*2*pi)**2/(x*I)

pdot_a1(x) = - a1_1(x) + muco(x)*(s1 - ang1)
pdot_a2(x) = - a2_1(x) + muco(x)*(s2 - ang2)



plot 'pulsar.dat' using 4:7 w p ls 1 t 'radio pulsar',     \
     'cco.dat' using 4:5 w p ls 2 t 'CCO',                 \
     'ins.dat' using 4:5 w p ls 3 t 'INS',                 \
     'magnetar.dat' using 4:5 w p ls 4 t 'magnetar',       \
     'rrat.dat' using 3:4 w p ls 7 t 'RRAT',               \
     pdot3(x) w l ls 5 t '',                               \
     pdot5(x) w l ls 5 t '',                               \
     pdot7(x) w l ls 5 t '',                               \
     pdot9(x) w l ls 5 t '',                               \
     mu12(x) w l ls 6 t '',                                \
     mu13(x) w l ls 6 t '',                                \
     mu14(x) w l ls 6 t '',                                \
     pdot_a1(x) w l ls 8 t '',                             \
     pdot_a2(x) w l ls 9 t '',                             \
     'Crab_p_pdot.dat' using 4:7 w p pt 110 ps 1.5 lc rgb '#FF00FF' t 'Crab'
