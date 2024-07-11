# minimal-python-project

A quick hack to create a 3D tiles struct from a tiled mesh with bounding box information inside

3D tiles specs
https://github.com/CesiumGS/3d-tiles

## Install
conda env create --file=environments.yml
conda activate mesh23Dtile

## Run example 
A minimal example on lidar HD stored in './datas/lidar_hd_crop/'
The result is created in  './output_lidarhd_crop/'
```console
./run.sh --input_dir datas/lidar_hd_crop/ --xml_file datas/lidar_hd_crop/metadata.xml  --output_dir ./output_lidarhd_crop/
```


# Notes : 

We use [Py3DTilers](https://github.com/VCityTeam/py3dtilers) to convert obj_file into 3Dtile (tileset + tileset.json).

LiDARHD laz file are in epsg:2154 coordinate system.
The resulting mesh is shifted for numerical stability
(coords="635471.0x6856430.0" in the lidar_hd.sh file)
There is actually two mode : 
- mode_proj=0 that convert obj file in b3dm and add a 4x4 transformation matrix in the tileset.json
- mode_proj=1 that first convert obj in epsg:4979 and write the bouiding volume as region in epsg:4978 coordinates

The result with mode_proj:
![result](./doc/res.png)

