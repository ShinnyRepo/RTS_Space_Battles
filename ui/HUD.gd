extends Spatial

const MAX_ZOOM_IN = 5
#world map gets unloaded after zooming out too far
const MAX_ZOOM_OUT = 60 
const MOVE_MARGIN = 20
const MOVE_SPEED = 40
const RAY_LENGTH = (MAX_ZOOM_IN + MAX_ZOOM_OUT) * 3

onready var cam = $Camera

signal hud_command(action, units, option)

var xzMax:Vector2 = Vector2(500,500)
var xzMin:Vector2 = Vector2(500,500)

var selected_units:Array = []

func setup(xzmax:Vector2, xzmin:Vector2, starting_pos:Vector2):
	xzMax = xzmax
	xzMin = xzmin
	global_translate(Vector3(starting_pos.x, 0, starting_pos.y))

func _process(delta):
	var m_pos:Vector2 = Vector2(0, 0)

	if Input.is_action_pressed("ui_up"):
		m_pos.y -= 1
	if Input.is_action_pressed("ui_down"):
		m_pos.y += 1
	if Input.is_action_pressed("ui_right"):
		m_pos.x += 1
	if Input.is_action_pressed("ui_left"):
		m_pos.x -= 1
	if (m_pos == Vector2(0, 0)):
		m_pos = get_viewport().get_mouse_position()

	calc_move(m_pos, delta)

#handles all inputs into the galaxy
#this insures the hud gui takes priority
func _unhandled_input(event:InputEvent):
	if event is InputEventMouseButton:
		var m_pos = get_viewport().get_mouse_position()

		if event.is_action_pressed("select"):
			get_item_at_mouse(m_pos, 6)
		if event.is_action_pressed("action"):
			var item = raycast_from_mouse(m_pos, 14)
			if item:
				move_units_towards_target(item.collider, item.position)
		if event.is_action_pressed("zoom_in"):
			cam.translation.z = max(cam.translation.z-5, MAX_ZOOM_IN)
		if event.is_action_pressed("zoom_out"):
			cam.translation.z = min(cam.translation.z+5, MAX_ZOOM_OUT)

func calc_move(m_pos:Vector2, delta):
	var v_size = get_viewport().size
	var move_vec = Vector3()
	
	if (m_pos.x == 1 || m_pos.x == -1 || \
		m_pos.y == 1 || m_pos.y == -1):
		move_vec.x = m_pos.x
		move_vec.z = m_pos.y
	else:
		if m_pos.x < MOVE_MARGIN:
			move_vec.x -= 1
		if m_pos.y < MOVE_MARGIN:
			move_vec.z -= 1
		if m_pos.x > v_size.x - MOVE_MARGIN:
			move_vec.x += 1
		if m_pos.y > v_size.y - MOVE_MARGIN:
			move_vec.z += 1

	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation_degrees.y)
	global_translate(move_vec * delta * MOVE_SPEED)
	translation.x = clamp(translation.x, xzMin.x, xzMax.x)
	translation.z = clamp(translation.z, xzMin.y, xzMax.y)

func raycast_from_mouse(m_pos, collision_mask):
	var ray_start = cam.project_ray_origin(m_pos)
	var ray_end = ray_start + cam.project_ray_normal(m_pos) * RAY_LENGTH
	var space_state = get_world().direct_space_state
	return space_state.intersect_ray(ray_start, ray_end, [], collision_mask)

func get_item_at_mouse(m_pos, collision_mask):
	var item = raycast_from_mouse(m_pos, collision_mask)
	if item:
		var col = item.collider
		if col.collision_mask & Global.Layers.UNITS != 0:
			selected_units.clear()
			selected_units.append(col)
		return col
	else:
		selected_units.clear()

func move_units_towards_target(target, pos):
	pos.y = 0
	if selected_units.size() > 0:
		if target.collision_mask & (Global.Layers.STATIONS | Global.Layers.UNITS) != 0:
			var attacking_units:Array = []
			var moving_units:Array = []

			for unit in selected_units:
				if unit.has_method("attack"):
					attacking_units.append(unit)
				else:
					moving_units.append(unit)

			if attacking_units.size() > 0:
				emit_signal("hud_command", Global.Action.Attack, attacking_units, target)
			emit_signal("hud_command", Global.Action.Move, moving_units, pos)
		else:
			emit_signal("hud_command", Global.Action.Move, selected_units, pos)
