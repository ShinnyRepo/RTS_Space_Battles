extends Spatial

onready var hud = $HUD

func _ready():
	var world_size = Vector2(500, 500)
	hud.setup(world_size/2, -1*(world_size/2), Vector2(0,0))
