extends CanvasLayer

#var NAME = ProjectSettings["application/config/name"]
var MASTERVOL = "master volume" 
var EFFECTSVOL = "effects volume"
var MUSICVOL = "music volume"
var FULLSCREEN = "window mode"

var CB_MODE = "colorblind mode"
var CB_INTENSITY = "colorblind intensity" 

@onready var cb_menu = %colorblind_type.get_popup() as PopupMenu

var is_loading := false
func _ready():
	visible = false
	$ColorRect.modulate = Color.TRANSPARENT
	if not _INIT.is_loaded: await _INIT.loaded
	is_loading = true
	if _INIT.data.has(MASTERVOL):
		%vol_master.value = _INIT.data[MASTERVOL] * 100
	else:
		%vol_master.value = 50
	if _INIT.data.has(EFFECTSVOL):
		%vol_effects.value = _INIT.data[EFFECTSVOL] * 100
	else:
		%vol_effects.value = 50
	if _INIT.data.has(MUSICVOL):
		%vol_music.value = _INIT.data[MUSICVOL] * 100
	else:
		%vol_music.value = 50
	if _INIT.data.has(FULLSCREEN):
		%fullscreen_toggle.button_pressed = _INIT.data[FULLSCREEN] == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
	else:
		%fullscreen_toggle.button_pressed = false
	if _INIT.data.has(CB_MODE):
		set_cb_mode(_INIT.data[CB_MODE])
	else:
		set_cb_mode(0)
	if _INIT.data.has(CB_INTENSITY):
		%colorblind_intensity.value = _INIT.data[CB_INTENSITY] * 100
	else:
		%colorblind_intensity.value = 0
		
	is_loading = false
	_INIT.Save()
	await get_tree().process_frame
	cb_menu.id_pressed.connect(set_cb_mode)
	
	
signal colorblind_changed
func set_cb_mode(mode):
	mode = clampi(mode,0,2)
#	if not _INIT.data.has(CB_MODE) or _INIT.data[CB_MODE] != mode:
	_INIT.data[CB_MODE] = mode
	%colorblind_type.text = cb_menu.get_item_text(mode)
	emit_signal("colorblind_changed")
	if not is_loading: _INIT.Save()
	


var pause_cache = false
var mode_cache = _IMP.WAITING
@export var time_to_tween = 0.25
func summon(title := false):
	%title.visible = not title
	mode_cache = _IMP.mode
	_IMP.mode = _IMP.TRANSITION
	visible = true
	var tree = get_tree()
	pause_cache = tree.paused
	tree.paused = true
	var tween = tree.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($ColorRect,"modulate",Color.WHITE,time_to_tween)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	%back.grab_focus()
	await tween.finished
	_IMP.mode = _IMP.MENU
	
signal options_dismissed
func dismiss():
	var tree = get_tree()
	_IMP.mode = _IMP.TRANSITION
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($ColorRect,"modulate",Color.TRANSPARENT,time_to_tween)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await  tween.finished
	visible = false
	tree.paused = pause_cache
	_IMP.mode = mode_cache
	emit_signal("options_dismissed")

func _on_back_pressed():
	dismiss()

func _on_vol_master_value_changed(value):
	var v := float(value) / 100.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(v))
	_INIT.data[MASTERVOL] = v
	if not is_loading: _INIT.Save()

func _on_vol_music_value_changed(value):
	var v := float(value) / 100.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"),linear_to_db(v))
	_INIT.data[MUSICVOL] = v
	if not is_loading: _INIT.Save()


func _on_vol_effects_value_changed(value):
	var v := float(value) / 100.0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("effects"),linear_to_db(v))
	_INIT.data[EFFECTSVOL] = v
	if not is_loading: _INIT.Save()


func _on_fullscreen_toggle_toggled(button_pressed):
	if _INIT.data[FULLSCREEN] != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN and button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	if _INIT.data[FULLSCREEN] == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN and not button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	_INIT.data[FULLSCREEN] = DisplayServer.window_get_mode()
	if not is_loading: _INIT.Save()
	


func _on_exit_pressed():
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_title_pressed():
	dismiss()
	_FADE.FadeTo("res://addons/title_screen/title_screen.tscn")


func _on_colorblind_intensity_value_changed(value):
	_INIT.data[CB_INTENSITY] = float(value)/100.0
	emit_signal("colorblind_changed")
	if not is_loading: _INIT.Save()
