input_dir=/home/LCaraffa/code/spark-ddt-release/outputs/ex_run_lidarhd_crop/app-20240610092715-0000_10_06_2024_09_27_31_generated/plydist_coef_mult_lag_seg_lagrange_weight_0_ll_2_cm_5_50_seg_lagrange_weight_10_06_2024_09_29_31_gc_1_049

output_dir=${PWD}/output_lidarhd_crop

mkdir -p  ${output_dir}
#python3  ./mesh23dtile.py --input_dir  ${input_dir} --output_dir ${output_dir} --meshlab_mode python 


# Loop through all OBJ files in the input directory
for obj_file in ${output_dir}/tiles/*.obj; do
    filename_we="${obj_file%.*}"
    python3 convert_obj.py --input ${obj_file}  --output ${filename_we}_trans.obj
    echo $filename_without_extension
    obj23dtiles -i "${filename_we}_trans.obj"  --b3dm
    obj23dtiles -i "${filename_we}.obj"  --b3dm
done

sed -i 's/\.obj/\.b3dm/g' ${output_dir}/tileset.json

# for obj_file in ${output_dir}/tiles/*.obj;do
#     base_name=$(basename "$obj_file" .obj)
#     echo "python3 translate_mesh.py --input ${obj_file}  --output ${base_name}_trans.ply"
# done
