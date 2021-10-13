extends Control

onready var ipAddressTextEdit:TextEdit = $VBoxContainer/IPEdit
onready var localCheck:CheckBox = $VBoxContainer/IsHostCheckBox
onready var hostCheck:CheckBox = $VBoxContainer/IsHostCheckBox
onready var hostIPLabel:Label = $VBoxContainer/HostIPLabel
onready var hostIPTextEdit:TextEdit = $VBoxContainer/HostIPTextEdit
onready var portLabel:Label = $VBoxContainer/PortLabel
onready var portTextEdit:TextEdit = $VBoxContainer/PortEdit
onready var invalidHostIPLabel:Label = $VBoxContainer/InvalidHostIPLabel
onready var invalidPortLabel:Label = $VBoxContainer/InvalidPortLabel

var parent:Node
var net:Network

func setup(caller:Node):
	self.parent = caller
	net = Network.new()
	ipAddressTextEdit.text = net.get_local_ip_address()
	portTextEdit.text = net.get_default_port()

func _on_BackButton_button_down():
	parent.change_current_scene(Global.Scene.MENU)

func _on_ContinueButton_button_down():
	net.IP_Address = ipAddressTextEdit.text
	net.Port = int(portTextEdit.text)
	net.Host_IP_Address = hostIPTextEdit.text
	
	if localCheck.pressed:
		#TODO: pass single player network
		var params = [Global.Scene.LOCAL, net]
		parent.change_current_scene(Global.Scene.LOBBY, params)
	elif net.Host_IP_Address.is_valid_ip_address():
		invalidHostIPLabel.visible = true
	elif net.Port > 65535 || net.Port <= 1024:
		invalidPortLabel.visible = true
	else:
		invalidHostIPLabel.visible = false
		
		if hostCheck.pressed:
			parent.change_current_scene(Global.Scene.LOBBY, net)
		else:
		#TODO: if host continue
		#otherwise must connect into the host before
		#moving forward
			pass

func _on_IsLocalCheckBox_button_down():
	hostCheck.visible = !hostCheck.visible
	portLabel.visible = !portLabel.visible
	portTextEdit.visible = !portTextEdit.visible
	
	if (!hostCheck.pressed):
		_on_IsHostCheckBox_button_down()

func _on_IsHostCheckBox_button_down():
	hostIPLabel.visible = !hostIPLabel.visible
	hostIPTextEdit.visible = !hostIPTextEdit.visible

func _on_HostIPTextEdit_text_changed():
	invalidHostIPLabel.visible = false

func _on_PortEdit_text_changed():
	invalidPortLabel.visible = false
