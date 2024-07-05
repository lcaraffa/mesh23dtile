#!/bin/bash

input_dir="${PWD}/datas/lidar_hd_crop"
output_dir="${PWD}/output_lidarhd_crop"
coords="635471.0x6856430.0"
offset="635471.0 6856430.0"
mode_proj=0 # convert obj file in b3dm and add a 4x4 transformation matrix in the tileset.json
#mode_proj=1 # first convert obj in epsg:4979 and write the bounding volume as region in epsg:4978 coordinates
tileset="${PWD}/3Dtile"
input_crs="2154"
output_crs="4978"
output_merge="${PWD}/FINAL_3Dtile"

# PLY --> OBJ
if [ -d "${output_dir}" ]; then
    echo "suppression ${output_dir}"
    rm -rf "${output_dir}"
fi
echo "create ${output_dir}"
mkdir -p "${output_dir}"
echo "begin mesh23tile"
python3  ./mesh23dtile.py --input_dir  ${input_dir} --output_dir ${output_dir} --meshlab_mode python --coords ${coords} --mode_proj ${mode_proj}
echo "end mesh23dtile.py"

# OBJ --> 3Dtile
if [ -d "${tileset}" ]; then
    rm -rf "${tileset}"
fi

count=0
for obj_file in "${output_dir}/tiles/"*.obj; do
    # mode_proj = 0:
    count=$((count + 1))
    output_tile=${tileset}_${count}
    obj-tiler -i "$obj_file" --offset ${offset} --crs_in EPSG:${input_crs} --crs_out EPSG:${output_crs} -o ${output_tile}
    # TODO: mode_proj = 1
done

parent_path="${PWD}"

merge_path=""

for dir in $parent_path/*; do
    if [ -d "$dir" ] && [[ "$dir" == *3Dtile* ]]; then
        merge_path+="$dir "
    fi
done

if [ -n "${merge_path}" ]; then
    tileset-merger --path ${merge_path} -o ${output_merge}
else
    echo "No '3Dtile' folder find"
fi
