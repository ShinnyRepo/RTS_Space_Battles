extends Spatial

onready var galaxy = $"."
onready var space = $Space
onready var stations = $Stations
onready var entities = $Entities
onready var environment = $SpaceEnvironment

var parent:Node
var network:Network

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

	
	print("loading hud")
	var cam_resource = load("res://ui/HUD.tscn")
	var camera = cam_resource.instance()
	galaxy.add_child(camera)
