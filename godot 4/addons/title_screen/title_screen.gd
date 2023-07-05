extends ColorRect


func _ready():
	_IMP.mode = _IMP.MENU
	_MUSIC.SwitchToSong("res://addons/title_screen/oath reborn by youfulca.ogg")
	%start.grab_focus()
	_IMP.input_mode_changed.connect(_on_input_mode_changed)


func _on_options_pressed():
	_OPTIONS.summon(true)
	await _OPTIONS.options_dismissed
	%options.grab_focus()


func _on_exit_pressed():
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_credits_pressed():
	_FADE.FadeTo("res://addons/title_screen/credits.tscn")

func _on_input_mode_changed(mode):
	if mode == _IMP.WAITING: _IMP.mode = _IMP.MENU


func _on_start_pressed():
	_FADE.FadeTo("res://gameplay.tscn")
