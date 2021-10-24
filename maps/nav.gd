extends Navigation

onready var draw:ImmediateGeometry = $NavMesh/draw3d
onready var plane:MeshInstance = $NavMesh/Plane

export var grid_size:int = 10

func _ready():
	var size = plane.mesh.size
	var length = (size.x / grid_size) + 1
	var width = (size.y / grid_size) + 1
	var current_point = size / -2
	var point:Vector3 = Vector3(current_point.x, 0, current_point.y)
	
	draw.begin(Mesh.PRIMITIVE_LINES)
	draw.set_color(Color(1.0,0.0,1.0,0.1))

	for l in length:
		draw.add_vertex(point)
		point.z *= -1
		draw.add_vertex(point)
		point.z *= -1
		point.x += grid_size

	point = Vector3(current_point.x, 0, current_point.y)
	for w in width:
		draw.add_vertex(point)
		point.x *= -1
		draw.add_vertex(point)
		point.x *= -1
		point.z += grid_size
	draw.end()
