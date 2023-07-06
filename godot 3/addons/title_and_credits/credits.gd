extends ColorRect

func _ready():
	$"%return".grab_focus()



func _on_return_pressed():
	_FADER.FadeTo("res://addons/title_and_credits/title_screen.tscn")
