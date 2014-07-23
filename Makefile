all: chair

chair: kitchen_chair.scad
	openscad -o kitchen_chair.stl -D'MODE="layout"' kitchen_chair.scad
	openscad -o kitchen_chair.dxf -D'MODE="2dlayout"' kitchen_chair.scad
	openscad -o kitchen_chair.png --camera=23,-3,-17,77,0,124,240 -D'MODE="model"' kitchen_chair.scad

clean:
	rm -f kitchen_chair.stl kitchen_chair.dxf kitchen_chair.png
