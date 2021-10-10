extends Control

var parent:Node

func setup(parent:Node):
	self.parent = parent

func _on_CustomButton_button_down():
	parent.change_current_scene(Global.Scene.CUSTOM)

func _on_MultiplayerButton_button_down():
	parent.change_current_scene(Global.Scene.LOBBY)

func _on_CreditsButton_button_down():
	parent.change_current_scene(Global.Scene.CREDIT)

func _on_QuitButton_button_down():
	parent.change_current_scene(Global.Scene.QUIT)

func _on_Button_mouse_entered():
	#User is actively moving around on the menu screen so don't
	#switch to the splash screen
	_reset_SpashScreenTimer()

func _on_SpashScreenTimer_timeout():
	parent.change_current_scene(Global.Scene.SPLASH)

func _reset_SpashScreenTimer():
	$SpashScreenTimer.stop()
	$SpashScreenTimer.wait_time = 360
	$SpashScreenTimer.start()
