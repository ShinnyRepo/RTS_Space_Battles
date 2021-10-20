extends Control

var parent:Node
var previous_scene
var network:Network
var settings:Galaxy_Settings

func setup(control:Node, params:Array):
	parent = control
	previous_scene = params[0]
	network = params[1]
	settings = Galaxy_Settings.new()

func _on_MenuButton_button_down():
	parent.change_current_scene(Global.Scene.MENU)

func _on_PreviousButton_button_down():
	parent.change_current_scene(previous_scene)

func _on_LaunchButton_button_down():
	var params = [network, settings]
	
	#verify all settings are set
	#currently in debug
	if true:
		settings.map_size = Vector2(500, 500)
		settings.starting_pos = Vector2(0, 0)
		settings.galaxy_map = load("res://maps/default.tscn")
		settings.space_env = load("res://resources/nebula.tres")
		settings.starting_ship = load("res://ships/construction.tscn")
	
	parent.change_current_scene(Global.Scene.GAME, params)
