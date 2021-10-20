extends Spatial

onready var galaxy = $"."
onready var space = $Space
onready var stations = $Space/Stations
onready var entities = $Space/Entities
onready var environment = $SpaceEnvironment

var parent:Node
var network:Network
var settings:Galaxy_Settings

var camera

func setup(control, params):
	parent = control
	network = params[0]
	settings = params[1]

	load_game()

func load_game():
	print("loading shaders")
	environment.environment = settings.space_env

	print("loading world")
	var children = space.get_children()
	var first_child = space.get_child(0)

	for child in children:
		if child != first_child:
			space.remove_child(child)

	first_child.free()
	var base = settings.galaxy_map.instance()
	galaxy.remove_child(space)
	galaxy.add_child(base)
	galaxy.move_child(base, 0)
	
	for child in children:
		base.add_child(child)
	
	space.free()
	space = base.get_child(0)

	print("loading stations")
	var con_ship = settings.starting_ship.instance()
	con_ship.setup(space)
	entities.add_child(con_ship)
	con_ship.translation = Vector3(settings.starting_pos.x, 0, settings.starting_pos.y)

	print("loading hud")
	var cam_resource = load("res://ui/HUD.tscn")
	camera = cam_resource.instance()
	galaxy.add_child(camera)
	var vec = settings.map_size
	camera.setup(vec/2, -vec/2, settings.starting_pos)
