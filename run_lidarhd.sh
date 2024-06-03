input_dir=/home/LCaraffa/code/spark-ddt-release/outputs/ex_run_lidarhd_crop/app-20240603143620-0000_03_06_2024_02_36_35_generated/plydist_coef_mult_lag_seg_lagrange_weight_0_ll_2_cm_5_50_seg_lagrange_weight_03_06_2024_02_38_33_gc_1_049

output_dir=${PWD}/output_lidarhd_crop

mkdir -p  ./output/
python3  ./mesh23dtile.py --input_dir  ${input_dir} --output_dir ${output_dir} --meshlab_mode python 


# Loop through all OBJ files in the input directory
for obj_file in ${output_dir}/tiles/*.obj; do
  base_name=$(basename "$obj_file" .obj)  
  obj23dtiles -i "$obj_file"  --b3dm
done

sed -i 's/\.obj/\.b3dm/g' ${output_dir}/tileset.json

