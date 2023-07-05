extends Node2D
class_name RAD_BUTT

var has_focus = false
signal got_lit
signal got_unlit

func _ready():
	$AnimationPlayer.play("dim")
	
@export var enabled: bool:
	get:
		return not $Button.disabled
	set(value):
		$Button.disabled = not value
		if value: _set_button_hilight()
@export var sp_visible: bool:
	get:
		return $sp_position.visible
	set(value):
		$sp_position.visible = value
		
func _set_button_hilight():
	var lit = false
	if _MOUSE.Live and \
			$Button.get_rect().has_point(get_local_mouse_position()):
		lit = true
	if $Button.has_focus():
		lit = true
		change_focus(true)
	else:
		change_focus(false)
	if not enabled: lit = false
	if not visible: lit = false
	if not lit and $AnimationPlayer.current_animation == "gleam":
		$AnimationPlayer.play("dim")
		if visible: $select.play()
		emit_signal("got_unlit")
	if lit and $AnimationPlayer.current_animation == "dim":
		$AnimationPlayer.play("gleam")
		$select.play()
		emit_signal("got_lit")
	
func grab_focus():
	if not visible: return
	$Button.grab_focus()
	
	
signal clicked
func _on_button_gui_event(event):
	if $Button.disabled: return
	if not event is InputEventMouse and not event.is_action("ui_accept"): return
	if not event.is_pressed(): return
	if event is InputEventMouse:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN: return
		if event.button_index == MOUSE_BUTTON_WHEEL_UP: return
		if event.button_index == MOUSE_BUTTON_WHEEL_LEFT: return
		if event.button_index == MOUSE_BUTTON_WHEEL_RIGHT: return
	
	# Device of -1 indicates touchscreen pretending to be mouse. Thus, if the
	#  button isn't already focused, we focus it, so that players can choose
	#  their battle options **deliberately.**
	if event.device == -1 and not has_focus:
		grab_focus()
		has_focus = true
	else:
		emit_signal("clicked")

signal focus_changed(value)
func change_focus(value:bool):
	if has_focus == value: return
	emit_signal("focus_changed", value)
	await get_tree().process_frame
	has_focus = value

func play_click():
	$click.play()
