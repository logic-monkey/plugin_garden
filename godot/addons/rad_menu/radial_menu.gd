extends CanvasLayer
class_name RAD_MEN

@onready var button =\
		[
			%button0,
			%button1,
			%button2,
			%button3
		]
		
func _ready():
	%menu.visible = false
	pass
	
func _process(delta):
	if not %menu.visible: return
	if _IMP.mode != _IMP.RADIAL_MENU and _IMP.mode != _IMP.TRANSITION: return
	if Input.is_action_just_pressed("vp_up") or \
			Input.is_action_just_pressed("ui_up"):
		button[0].grab_focus()
	if Input.is_action_just_pressed("vp_right") or \
			Input.is_action_just_pressed("ui_right"):
		button[1].grab_focus()
	if Input.is_action_just_pressed("vp_down") or \
			Input.is_action_just_pressed("ui_down"):
		button[2].grab_focus()
	if Input.is_action_just_pressed("vp_left") or \
			Input.is_action_just_pressed("ui_left"):
		button[3].grab_focus()
		
@export var menu_screen_edge_buffer : int = 20
const MENU_HALFWIDTH = 220
var animating := false
func summon_from(location:Vector2, buttonry:Dictionary={}):
	if animating: await $AnimationPlayer.animation_finished
	animating = true
	_IMP.mode = _IMP.TRANSITION
	mouse_clear = false
	%menu.position = location
	var destination = location
	# Constrain the destination within the viewport
	if destination.x < MENU_HALFWIDTH + menu_screen_edge_buffer:
		destination.x = MENU_HALFWIDTH + menu_screen_edge_buffer
	var max = get_viewport().get_visible_rect().size.x - MENU_HALFWIDTH - menu_screen_edge_buffer
	if destination.x > max: destination.x = max
	if destination.y < MENU_HALFWIDTH + menu_screen_edge_buffer:
		destination.y = MENU_HALFWIDTH + menu_screen_edge_buffer
	max = get_viewport().get_visible_rect().size.y - MENU_HALFWIDTH - menu_screen_edge_buffer
	if destination.y > max: destination.y = max
	$AnimationPlayer.play("summon")
	var tween = create_tween()
	tween.tween_property(%menu, "position", destination, 0.25).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await $AnimationPlayer.animation_finished
	animating = false
	_IMP.mode = _IMP.RADIAL_MENU
	
const CANCEL = -1
signal menu_done(result)

var mouse_clear := false
func _unhandled_input(event):
	if animating: return
	if _IMP.mode != _IMP.RADIAL_MENU: return
	if not visible: return
	if (not event is InputEventMouseButton) and (not event.is_action_pressed("ui_cancel")): return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN: return
		if event.button_index == MOUSE_BUTTON_WHEEL_UP: return
		if event.button_index == MOUSE_BUTTON_WHEEL_LEFT: return
		if event.button_index == MOUSE_BUTTON_WHEEL_RIGHT: return
	emit_signal("menu_done", CANCEL)
	animating = true
	_IMP.mode = _IMP.TRANSITION
	$AnimationPlayer.play("dismiss")
	await $AnimationPlayer.animation_finished
	animating = false
	if _IMP.mode == _IMP.TRANSITION: _IMP.mode = _IMP.WAITING
	
func _on_button_clicked(index):
	if animating: return
	if _IMP.mode != _IMP.RADIAL_MENU: return
	animating = true
	button[index].play_click()
	emit_signal("menu_done", index)
	animating = true
	_IMP.mode = _IMP.TRANSITION
	$AnimationPlayer.play("dismiss")
	await $AnimationPlayer.animation_finished
	animating = false
	if _IMP.mode == _IMP.TRANSITION: _IMP.mode = _IMP.WAITING
