mkdir -p  ./output/
python3  ./mesh23dtile.py --input_dir  ${PWD}/datas/croco --output_dir ${PWD}/output --meshlab_mode python  --bbox "-40 40 -40 40 -40 40"
sed -i 's/.obj/.b3dm/g'  ./output/tileset.json
