extends Area2D




func _on_input_event(viewport, event, shape_idx):
	if _IMP.mode != _IMP.EXPLORE: return
	if not event is InputEventMouseButton: return
	if not event.is_pressed(): return
	viewport.set_input_as_handled()
	_RAD.summon_from(get_global_mouse_position())
