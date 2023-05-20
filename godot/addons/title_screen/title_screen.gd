extends ColorRect


func _ready():
	%start.grab_focus()


func _on_options_pressed():
	_OPTIONS.summon()
	await _OPTIONS.options_dismissed
	%options.grab_focus()
