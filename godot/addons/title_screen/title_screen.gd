extends ColorRect


func _ready():
	%start.grab_focus()


func _on_options_pressed():
	_OPTIONS.summon(true)
	await _OPTIONS.options_dismissed
	%options.grab_focus()


func _on_exit_pressed():
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
