extends Node

onready var canvas_layer = $CanvasLayer

var current_scene

func _ready():
	#Change Scene here to default to a new window
	change_current_scene(Global.Scene.SPLASH)

func change_current_scene(scene:int, params=null):
	current_scene = scene
	var new_scene_resource:Resource

	match scene:
		Global.Scene.SPLASH:
			new_scene_resource = load("res://ui/menu/splash_screen.tscn")
		Global.Scene.CREDIT:
			new_scene_resource = load("res://ui/menu/credit_sceen.tscn")
		Global.Scene.MENU:
			new_scene_resource = load("res://ui/menu/menu_screen.tscn")
		Global.Scene.LOCAL:
			new_scene_resource = load("res://ui/menu/local_screen.tscn")
		Global.Scene.MATCH:
			new_scene_resource = load("res://ui/menu/match_making_scene.tscn")
		Global.Scene.LOBBY:
			new_scene_resource = load("res://ui/menu/game_lobby_scene.tscn")
		Global.Scene.GAME:
			new_scene_resource = load("res://ui/Galaxy.tscn")
		_:
			get_tree().quit()

	if current_scene != Global.Scene.QUIT:
		_change_scene(new_scene_resource, params)

func _change_scene(scene_resource:Resource, params=null):
	var old_scene
	if $CanvasLayer.get_child_count() > 0:
		old_scene = $CanvasLayer.get_child(0)
	var new_scene = scene_resource.instance()
	canvas_layer.add_child(new_scene)
	if new_scene.has_method("setup"):
		if params:
			new_scene.setup(self, params)
		else:
			new_scene.setup(self)
	if old_scene:
		$CanvasLayer.remove_child(old_scene)
		old_scene.call_deferred("free")

func _unhandled_input(event):
	if (current_scene == Global.Scene.SPLASH || current_scene == Global.Scene.CREDIT) && \
			not (event is InputEventMouseButton):
		change_current_scene(Global.Scene.MENU)

