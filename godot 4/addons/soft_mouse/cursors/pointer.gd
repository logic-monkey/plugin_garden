extends Node2D

var play_click := true
func _input(event):
	if not event is InputEventMouseButton: return
	if not visible: return
	if event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN: return
		if event.button_index == MOUSE_BUTTON_WHEEL_UP: return
		if event.button_index == MOUSE_BUTTON_WHEEL_LEFT: return
		if event.button_index == MOUSE_BUTTON_WHEEL_RIGHT: return
		$sprite.frame = 1
		if play_click:
			play_click = false
			$click.play()
	else: 
		$sprite.frame = 0
		play_click = true
