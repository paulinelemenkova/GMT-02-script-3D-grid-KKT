#!/bin/sh
# Purpose: 3D grid, 165/30 azimuth, from the ETOPO5 from 5 arc min (here: Kuril-Kamchatka Trench)
# GMT modules: grdcut, grd2cpt, grdcontour, pscoast, grdview, logo, psconvert
# Unix prog: rm
#
# Step-1. Cut grid
gmt grdcut earth_relief_05m.grd -R140/170/40/60 -Gkkt_relief.nc
# Step-2. Create color palette
gmt grd2cpt @kkt_relief.nc -Crainbow > rainbowKKT.cpt
# Step-3. generate a file
ps=Overlay3D165.ps
# Step-4. Add contour
gmt grdcontour geoid.egm96.grd -JM3.5i -R140/170/40/60 -p165/30 -C1 -A5 -Gd3c -Wthinnest,dimgray -Y3c -U/-0.5c/-1c/"Data: 2 min World Geoid Image 9.2, ETOPO 5 arc min grid" -P -K > $ps
# Step-5. Add coastlines, ticks, rose,
pscoast -J -R -p165/30 -B4/2NESW -Gdimgray -O -K -T168/42/1c \
    --MAP_ANNOT_OFFSET=0.1c >> $ps
# Step-6. Add 3D
grdview kkt_relief.nc -J -R -JZ2i -CrainbowKKT.cpt -p165/30 -Qsm -N-7500+glightgray \
    -Wm0.1p -Wf0.1p,red -Wc0.1p,magenta -B5/5/2000:"Bathymetry and topography (m)":nEswZ -Y4.5c \
    --FONT_LABEL=8p,Palatino-Bold,darkblue -O -K >> $ps
# Step-7. Add GMT logo
gmt logo -Dx10.5/0.0+o0.0c/-5.5c+w2c -O -K >> $ps
# Step-8. Add title
gmt pstext -R0/10/0/10 -Jx1 -X0.0c -Y0.0c -N -O -K \
-F+f10p,Palatino-Roman,black+jLB >> $ps << EOF
1.0 10.0 Overlay of the 3D topographic model on the 2D geoid contour plot
0.5 9.5 Region: Kamchatka Peninsula, Kuril-Kamchatka Trench, Kuril Islands
EOF
gmt pstext -R0/10/0/10 -Jx1 -X0.0c -Y0.0c -N -O \
-F+f8p,Palatino-Roman,dimgray+jLB >> $ps << EOF
7.0 9.0 Perspective view azimuth: 165/30\232
EOF
# Step-9. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert Overlay3D165.ps -A0.2c -E720 -Tj -P -Z
# Step-10. Clean up
rm -f rainbowKKT.cpt
