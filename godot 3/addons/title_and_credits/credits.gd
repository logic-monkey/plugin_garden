extends ColorRect

func _ready():
	$"%return".grab_focus()

func _on_return_pressed():
	_FADER.FadeTo("res://addons/pixel_art/pixel_title.tscn")
