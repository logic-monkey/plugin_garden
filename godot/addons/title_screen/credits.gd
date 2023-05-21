extends ColorRect

func _ready():
	%license.text = Engine.get_license_text()
	


func _on_title_pressed():
	_FADE.FadeTo("res://addons/title_screen/title_screen.tscn")


const SCROLL_AMT = 20
func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		$ScrollContainer.scroll_vertical += SCROLL_AMT
	elif Input.is_action_just_pressed("ui_up"):
		$ScrollContainer.scroll_vertical -= SCROLL_AMT
