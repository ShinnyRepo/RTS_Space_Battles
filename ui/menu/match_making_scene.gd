extends Control

var parent:Node
var net:Network

func setup(control:Node):
	parent = control
	net = Network.new()

func _on_BackButton_button_down():
	parent.change_current_scene(Global.Scene.MENU)

func _on_JoinButton_button_down():
	#TODO: connect to host first or create a game
	var params = [Global.Scene.MATCH, net]
	parent.change_current_scene(Global.Scene.LOBBY, params)


