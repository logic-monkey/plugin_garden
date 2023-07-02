extends Node2D


func _input(event):
	if _IMP.mode != _IMP.EXPLORE: return
	if not event is InputEventMouseButton: return
	if not event.is_pressed(): return
	if event.button_index == MOUSE_BUTTON_WHEEL_DOWN: return
	if event.button_index == MOUSE_BUTTON_WHEEL_UP: return
	if event.button_index == MOUSE_BUTTON_WHEEL_LEFT: return
	if event.button_index == MOUSE_BUTTON_WHEEL_RIGHT: return
	_RAD.summon_from(event.position)
