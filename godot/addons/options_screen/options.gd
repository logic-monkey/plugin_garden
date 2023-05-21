extends CanvasLayer

var NAME = ProjectSettings["application/config/name"]
var MASTERVOL = "master volume %s" % NAME
var EFFECTSVOL = "effects volume %s" % NAME
var MUSICVOL = "music volume %s" % NAME
var FULLSCREEN = "window mode %s" % NAME

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
	is_loading = false
	_INIT.Save()


var pause_cache = false
@export var time_to_tween = 0.25
func summon(title := false):
	%title.visible = not title
	visible = true
	var tree = get_tree()
	pause_cache = tree.paused
	tree.paused = true
	var tween = tree.create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($ColorRect,"modulate",Color.WHITE,time_to_tween)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	%back.grab_focus()
	
signal options_dismissed
func dismiss():
	var tree = get_tree()
	var tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($ColorRect,"modulate",Color.TRANSPARENT,time_to_tween)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await  tween.finished
	visible = false
	tree.paused = pause_cache
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
