@tool
#@icon("vpad icon.svg")
extends Node
class_name VirtualGamepad

var stick: Vector2 = Vector2.ZERO

var buttons: Dictionary = {}

func _ready():
	if Engine.is_editor_hint(): return
	for child in get_children():
		if child is _VB:
			buttons[child.name] = child

#func _process(_delta):
#	if Engine.is_editor_hint(): return
#
#	#Clear the Stick at the start of the frame.
#	await get_tree().process_frame
#	stick = Vector2.ZERO

func is_button_down(button: String) -> bool:
	if not button in buttons: return false
	return buttons[button].is_down
	
func check_button(button: String, consume:= true)->bool:
	if not button in buttons: return false
	var rv : bool = buttons[button].live
	if rv and consume: buttons[button].live = false
	return rv
	
func consume_button(button: String):
	if not button in buttons: return
	buttons[button].live = false

