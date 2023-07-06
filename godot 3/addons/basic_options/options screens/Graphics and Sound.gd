extends Panel

const MASTER = "master volume"
const FX = "sound effects volume"
const MUSIC = "music volume"
const FULLSCREEN = "game fullscreen"

var loading := false
func _ready():
	#On your mark
	loading = true
	if not _INI.is_loaded:
		yield(_INI,"loaded")

	#Load data
	if MASTER in _INI.data:
		$"%master_volume".value = _INI.data[MASTER] * 100
	else:
		$"%master_volume".value = 50
	if FX in _INI.data:
		$"%effects_volume".value = _INI.data[FX] * 100
	else:
		$"%effects_volume".value = 100
	if MUSIC in _INI.data:
		$"%music_volume".value = _INI.data[MUSIC] * 100
	else:
		$"%music_volume".value = 100
	if FULLSCREEN in _INI.data:
		$"%fullscreen".pressed = _INI.data[FULLSCREEN]
	else:
		$"%fullscreen".pressed = OS.window_fullscreen

	#Wrap up
	loading = false
	_INI.Save()
	

func _on_master_volume_value_changed(value):
	_INI.data[MASTER] = float(value)/100
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear2db(_INI.data[MASTER]))
	if not loading:
		_INI.Save()

func _on_effects_volume_value_changed(value):
	_INI.data[FX] = float(value)/100
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("effects"),linear2db(_INI.data[FX]))
	if not loading:
		_INI.Save()

func _on_music_volume_value_changed(value):
	_INI.data[MUSIC] = float(value)/100
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music"),linear2db(_INI.data[MUSIC]))
	if not loading:
		_INI.Save()

func _on_fullscreen_toggled(button_pressed):
	_INI.data[FULLSCREEN] = button_pressed
	if not loading:
		_INI.Save()
	yield(get_tree(),"idle_frame")
	OS.window_fullscreen = button_pressed
