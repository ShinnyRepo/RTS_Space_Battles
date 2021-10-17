extends Spatial

onready var galaxy = $"."
onready var space = $Space
onready var stations = $Space/Stations
onready var entities = $Space/Entities
onready var environment = $SpaceEnvironment

var parent:Node
var network:Network

var camera

func setup(control, net):
	parent = control
	network = net[0]
	load_game()

func load_game():
	print("loading shaders")
	var env_resource = load("res://resources/nebula.tres")
	environment.environment = env_resource
	
	print("loading world")
	

	print("loading stations")
	var con_resource = load("res://ships/Contrustion_Ship.tscn")
	var con_ship = con_resource.instance()
	con_ship.setup(space)
	entities.add_child(con_ship)
	
	print("loading hud")
	var cam_resource = load("res://ui/HUD.tscn")
	camera = cam_resource.instance()
	galaxy.add_child(camera)
	var vec = $Space/NavigationMeshInstance/MeshInstance.mesh.size
	camera.setup(vec/2, -vec/2, Vector2(10, 50))
