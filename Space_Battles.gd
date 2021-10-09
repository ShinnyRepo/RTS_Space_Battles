extends Node

var current_scene

func _ready():
	change_current_scene(Global.Scene.SPLASH)

func change_current_scene(scene:int):
	current_scene = scene
	var new_scene_resource:Resource

	match scene:
		Global.Scene.SPLASH:
			new_scene_resource = load("res://ui/splash_screen.tscn")
		Global.Scene.MENU:
			new_scene_resource = load("res://ui/menu_screen.tscn")
		Global.Scene.LOBBY:
			pass
		Global.Scene.GAME:
			pass
		Global.Scene.CREDIT:
			new_scene_resource = load("res://ui/credit_sceen.tscn")
		_:
			get_tree().quit()

	if current_scene != Global.Scene.QUIT:
		_change_scene(new_scene_resource)

func _change_scene(scene_resource:Resource):
	var old_scene = $CanvasLayer.get_child(0)
	var new_scene = scene_resource.instance()
	$CanvasLayer.add_child(new_scene)
	if "parent" in new_scene:
		new_scene.parent = self
	if old_scene:
		$CanvasLayer.remove_child(old_scene)
		old_scene.call_deferred("free")

func _unhandled_input(event):
	if (current_scene == Global.Scene.SPLASH || current_scene == Global.Scene.CREDIT) && \
			not (event is InputEventMouseButton):
		change_current_scene(Global.Scene.MENU)

