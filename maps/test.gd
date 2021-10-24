extends Spatial

onready var hud = $HUD
onready var galaxy_plane = $Navigation/NavMesh/Plane

func _ready():
	var world_size = galaxy_plane.mesh.size
	hud.setup(world_size/2, -1*(world_size/2), Vector2(0,0))
