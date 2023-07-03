extends Area2D




func _on_input_event(viewport, event, shape_idx):
	if _IMP.mode != _IMP.EXPLORE: return
	if not event is InputEventMouseButton: return
	if not event.is_pressed(): return
	viewport.set_input_as_handled()
	var position = get_global_mouse_position()
	var rv = 500
	while (rv != -1):
		rv = await _RAD.get_menu_result(position)
		if rv != -1: position = _RAD.last_button_clicked_position
