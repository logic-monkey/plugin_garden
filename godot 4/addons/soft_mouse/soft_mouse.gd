extends CanvasLayer

var Live = false
@export var forceHideMouse : bool = false

func _input(event):
	if not event is InputEventMouse: return
	if forceHideMouse: return
	fadein()
	Live = true
	$Timer.start()
	%position.global_position = %position.get_global_mouse_position()
	
const fadetime := 0.2
func fadeout():
	Live = false
	if %position.modulate == Color.TRANSPARENT: return
	var tween = create_tween()
	tween.tween_property(%position, "modulate", Color.TRANSPARENT, fadetime).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	
func fadein():
	if %position.modulate == Color.WHITE: return
	var tween = create_tween()
	tween.tween_property(%position, "modulate", Color.WHITE, fadetime).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)


var icon_list = {}
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	var icons = %position.get_children()
	if "Mouse Fade Time" in _INIT.data: $Timer.timeout = _INIT.data["Mouse Fade Time"]
	else: _INIT.data["Mouse Fade Time"] = $Timer.timeout
	for icon in icons:
		icon_list[icon.name] = icon
		set_icon("pointer")
		
var current_icon: String
func set_icon(icon:String):
	if not icon in icon_list: return
	if icon == current_icon: return
	for icon_name in icon_list:
		icon_list[icon_name].visible = false
	icon_list[icon].visible = true
	current_icon = icon
