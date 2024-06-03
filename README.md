# minimal-python-project

A first draft to create a 3D tiles struct from a tiled mesh/
Does not work actually.

3D tiles specs
https://github.com/CesiumGS/3d-tiles

## Install
conda env create --file=environments.yml
conda activate mesh23Dtile

## Run example 
To run the example, just run 
```console
./run_example.sh
```
in the main dir, it will creates the output in the "output" dir


## TODO
- Read https://github.com/pka/awesome-3d-tiles

- convert obj to gltf 
  - https://github.com/arcplus/ObjConvert
  - https://github.com/VCityTeam/py3dtilers/tree/master
	- https://github.com/VCityTeam/py3dtilers/tree/master/py3dtilers/ObjTiler#obj-tiler
