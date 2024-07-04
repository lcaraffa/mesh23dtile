input_dir=${PWD}/datas/lidar_hd_crop
output_dir=${PWD}/output_lidarhd_crop
coords="635471.0x6856430.0"
mode_proj=0 #convert obj file in b3dm and add a 4x4 transformation matrix in the tileset.json
#mode_proj=1 #first convert obj in epsg:4979 and write the bouiding volume as region in epsg:4978 coordinates
tileset=${PWD}/3Dtile
input_crs="2154"
output_crs="4978"

# PLY --> OBJ
mkdir -p  ${output_dir}
python3  ./mesh23dtile.py --input_dir  ${input_dir} --output_dir ${output_dir} --meshlab_mode python --coords ${coords} --mode_proj ${mode_proj}

#OBJ --> 3Dtile
mkdir -p ${tileset}
for obj_file in ${output_dir}/tiles/*.obj; do
    # mode_proj = 0:
    obj-tiler -i $obj_file --offset ${coords} --crs_in EPSG:${input_crs} --crs_out EPSG:${output_crs} -o "${tileset}"
    # TODO: mode_proj = 1:
done

