extends ColorRect


func _ready():
	_MUSIC.SwitchToSong("res://addons/title_screen/oath reborn by youfulca.ogg")
	%start.grab_focus()


func _on_options_pressed():
	_OPTIONS.summon(true)
	await _OPTIONS.options_dismissed
	%options.grab_focus()


func _on_exit_pressed():
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_credits_pressed():
	_FADE.FadeTo("res://addons/title_screen/credits.tscn")
