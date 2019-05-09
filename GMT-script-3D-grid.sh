#!/bin/sh
# Purpose: 3D grid from the ETOPO5 from 5 arc minute global data set (here: Kuril-Kamchatka Trench)
# GMT modules: grdcut, grd2cpt, grdview
gmt grdcut earth_relief_05m.grd -R140/170/40/60 -Gkkt_relief.nc
gmt grd2cpt @kkt_relief.nc -Cocean > KKT.cpt
#azimuth 165/30
gmt grdview @kkt_relief.nc -JM5i -p165/30 -P -JZ2i  -Ba -Ctopo.cpt \
	--FONT_ANNOT_PRIMARY=7p,Helvetica,dimgray \
	--FONT_TITLE=12p,Helvetica,dimgray \
	--MAP_FRAME_WIDTH=0.08c --MAP_FRAME_PEN=dimgray \
	--FORMAT_GEO_MAP=dddF  \
	 > GMT_KKT-3D165.ps
#azimuth 135/30
gmt grdview @kkt_relief.nc -JM5i -p135/30 -P -JZ2i  -Ba -Ctopo.cpt --FONT_ANNOT_PRIMARY=7p,Helvetica,dimgray \
	--FONT_TITLE=12p,Helvetica,dimgray \
	--MAP_FRAME_WIDTH=0.08c --MAP_FRAME_PEN=dimgray \
	--FORMAT_GEO_MAP=dddF \
	 > GMT_KKT-3D135.ps
