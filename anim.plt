#!/usr/bin/gnuplot

sourceFile = 'simvent1.dat'
stat sourceFile using 'time' name 'TIME'
stat sourceFile using 'Flung' name 'FLUNG'
stat sourceFile using 'Pao' name 'PAO'
stat sourceFile using 'Vt' name 'VT'

svSampl = 0.003
d = 4 # * 0.01 sec
ds = d * 0.01
lpd = floor(ds/svSampl)
tStart = 3
s = floor(tStart / svSampl)
print s

set terminal gif animate size 600, 450 delay d font ",10"
set output 'test.gif'

set style data filledcurve y=0
set linetype 1 lc "steelblue" lw 1
set linetype 2 lc "black"
unset border
set zeroaxis ls 2
set key samplen 1

set xrange [0:TIME_max]

set tics nomirror
#set tics axis
do for [h=1:TIME_records/lpd] {
set multiplot layout 3,1

	datfile = gprintf("<head -%g simvent1.dat", h * lpd)
	set yrange [0:PAO_max * 1.3]
	plot datfile using 'time':'Pao'

	set yrange [FLUNG_min * 1.3:FLUNG_max * 1.3]
	plot datfile using 'time':'Flung'

	set yrange [0:VT_max * 1.3]
	plot datfile using 'time':'Vt'
	unset multiplot
}
