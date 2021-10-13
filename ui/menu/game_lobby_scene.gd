extends Control

var parent:Node
var previous_scene
var network

func setup(control:Node, params:Array):
	parent = control
	previous_scene = params[0]
	network = params[1]
	
func _on_MenuButton_button_down():
	parent.change_current_scene(Global.Scene.MENU)

func _on_PreviousButton_button_down():
	parent.change_current_scene(previous_scene)

func _on_LaunchButton_button_down():
	var params = [network]
	parent.change_current_scene(Global.Scene.GAME, params)
