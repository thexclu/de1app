#!/bin/bash

convert ~/Desktop/insight_dark0000.tif preheat_1.png &
convert ~/Desktop/insight_dark0001.tif preheat_2.png &
convert ~/Desktop/insight_dark0002.tif preheat_3.png &
convert ~/Desktop/insight_dark0003.tif preheat_4.png &

convert ~/Desktop/insight_dark0004.tif espresso_1.png &
convert ~/Desktop/insight_dark0005.tif espresso_1_zoomed.png &
convert ~/Desktop/insight_dark0006.tif espresso_2.png &
convert ~/Desktop/insight_dark0007.tif espresso_2_zoomed.png &
convert ~/Desktop/insight_dark0008.tif espresso_3.png &
convert ~/Desktop/insight_dark0009.tif espresso_3_zoomed.png &

convert ~/Desktop/insight_dark0010.tif steam_1.png &
convert ~/Desktop/insight_dark0011.tif steam_2.png &
convert ~/Desktop/insight_dark0012.tif steam_3.png &

convert ~/Desktop/insight_dark0013.tif water_1.png &
convert ~/Desktop/insight_dark0014.tif water_2.png &
convert ~/Desktop/insight_dark0015.tif water_3.png &

wait

rm ~/Desktop/insight_dark0000.tif 
rm ~/Desktop/insight_dark0001.tif 
rm ~/Desktop/insight_dark0002.tif 
rm ~/Desktop/insight_dark0003.tif 

rm ~/Desktop/insight_dark0004.tif 
rm ~/Desktop/insight_dark0005.tif 
rm ~/Desktop/insight_dark0006.tif 
rm ~/Desktop/insight_dark0007.tif 

rm ~/Desktop/insight_dark0008.tif 
rm ~/Desktop/insight_dark0009.tif 
rm ~/Desktop/insight_dark0010.tif 

rm ~/Desktop/insight_dark0011.tif 
rm ~/Desktop/insight_dark0012.tif 
rm ~/Desktop/insight_dark0013.tif 
rm ~/Desktop/insight_dark0014.tif 
rm ~/Desktop/insight_dark0015.tif 

zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y preheat_1.png preheat_1.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y preheat_2.png preheat_2.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y preheat_3.png preheat_3.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y preheat_4.png preheat_4.png &

wait

zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y espresso_1.png espresso_1.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y espresso_1_zoomed.png espresso_1_zoomed.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y espresso_2.png espresso_2.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y espresso_2_zoomed.png espresso_2_zoomed.png &

wait

zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y espresso_3.png espresso_3.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y espresso_3_zoomed.png espresso_3_zoomed.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y steam_1.png steam_1.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y steam_2.png steam_2.png &

wait

zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y steam_3.png steam_3.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y water_1.png water_1.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y water_2.png water_2.png &
zopflipng --always_zopflify --lossy_transparent -q --iterations=1 -y water_3.png water_3.png &

wait

cd ../../..
./skinresize.tcl

exit


convert ~/Desktop/charts_skin0000.png preheat_1.png
convert ~/Desktop/charts_skin0001.png preheat_2.png
convert ~/Desktop/charts_skin0002.png preheat_3.png
convert ~/Desktop/charts_skin0003.png preheat_4.png

convert ~/Desktop/charts_skin0004.png espresso_1.png
convert ~/Desktop/charts_skin0005.png espresso_1_zoomed.png
convert ~/Desktop/charts_skin0006.png espresso_2.png
convert ~/Desktop/charts_skin0007.png espresso_2_zoomed.png
convert ~/Desktop/charts_skin0008.png espresso_3.png
convert ~/Desktop/charts_skin0009.png espresso_3_zoomed.png

convert ~/Desktop/charts_skin0010.png steam_1.png
convert ~/Desktop/charts_skin0011.png steam_2.png
convert ~/Desktop/charts_skin0012.png steam_3.png

convert ~/Desktop/charts_skin0013.png water_1.png
convert ~/Desktop/charts_skin0014.png water_2.png
convert ~/Desktop/charts_skin0015.png water_3.png

rm ~/Desktop/charts_skin0000.png 
rm ~/Desktop/charts_skin0001.png 
rm ~/Desktop/charts_skin0002.png 
rm ~/Desktop/charts_skin0003.png 

rm ~/Desktop/charts_skin0004.png 
rm ~/Desktop/charts_skin0005.png 
rm ~/Desktop/charts_skin0006.png 
rm ~/Desktop/charts_skin0007.png 

rm ~/Desktop/charts_skin0008.png 
rm ~/Desktop/charts_skin0009.png 
rm ~/Desktop/charts_skin0010.png 

rm ~/Desktop/charts_skin0011.png 
rm ~/Desktop/charts_skin0012.png 
rm ~/Desktop/charts_skin0013.png 
rm ~/Desktop/charts_skin0014.png 
rm ~/Desktop/charts_skin0015.png 

