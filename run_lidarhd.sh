#!/bin/bash

input_dir="/home/LCaraffa/outputs/outputs_lidarhd/LHD_FXX_0635_6857_PTS_C_LAMB93_IGN69.copc.laz/outputs/tiles/"
#input_dir=${PWD}/datas/lidar_hd_crop
output_dir="${PWD}/output_lidarhd_crop"
coords="635000.0x6856000.0"
offset="635000.0 6856000.0"
mode_proj=0 # convert obj file in b3dm and add a 4x4 transformation matrix in the tileset.json
#mode_proj=1 # first convert obj in epsg:4979 and write the bounding volume as region in epsg:4978 coordinates
tileset="${PWD}/3Dtile"
input_crs="2154"
output_crs="4978"
output_merge="${PWD}/FINAL_3Dtile"


echo "create ${output_dir}"
mkdir -p "${output_dir}"
echo "begin mesh23tile"
python3  ./mesh23dtile.py --input_dir  ${input_dir} --output_dir ${output_dir} --meshlab_mode python --coords ${coords} --mode_proj ${mode_proj}
echo "end mesh23dtile.py"

count=0
for obj_file in "${output_dir}/tiles/"*.obj; do
    count=$((count + 1))
    output_tile=${output_dir}/$(basename ${obj_file%.*})
    echo ${offset}
    obj-tiler -i "$obj_file" --offset ${offset} --crs_in EPSG:${input_crs} --crs_out EPSG:${output_crs} -o ${output_tile}
done 

python3 finalize.py ${output_dir}
