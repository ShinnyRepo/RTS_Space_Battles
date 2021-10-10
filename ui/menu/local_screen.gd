extends Control

var parent:Node
var net_Params

onready var localCheck:CheckBox = $VBoxContainer/IsHostCheckBox
onready var isHostCheck:CheckBox = $VBoxContainer/IsHostCheckBox
onready var hostIPLabel:Label = $VBoxContainer/HostIPLabel
onready var hostIPTextEdit:TextEdit = $VBoxContainer/HostIPTextEdit
onready var portLabel:Label = $VBoxContainer/PortLabel
onready var portTextEdit:TextEdit = $VBoxContainer/PortEdit

func setup(parent:Node):
	self.parent = parent
	var net_Params_Resource:GDScript = load("res://scripts/network_params.gd")
	net_Params = net_Params_Resource.new()

func _on_BackButton_button_down():
	parent.change_current_scene(Global.Scene.MENU)

func _on_ContinueButton_button_down():
	net_Params.HostIP = hostIPTextEdit.text
	net_Params.Port = portTextEdit.text
	net_Params.Parent_Scene = parent
	
	parent.change_current_scene(Global.Scene.GAME, net_Params)

func _on_IsLocalCheckBox_button_down():
	var islocalChecked = localCheck.toggle_mode
	isHostCheck.visible = islocalChecked
	portLabel.visible = islocalChecked
	portTextEdit.visible = islocalChecked

func _on_IsHostCheckBox_button_down():
	var isToggled = isHostCheck.toggle_mode
	hostIPLabel.visible = isToggled
	hostIPTextEdit.visible = isToggled
