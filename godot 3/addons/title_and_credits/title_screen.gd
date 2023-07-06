extends Control

func _ready():
	_FADER.FadeIn()
	$"%start".grab_focus()
	


func _on_exit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_start_pressed():
	_FADER.FadeTo("res://gameplay.tscn")


func _on_credits_pressed():
	_FADER.FadeTo("res://addons/title_and_credits/credits.tscn")


func _on_options_pressed():
	_OPT.summon(true)
	yield(_OPT,"options_done")
	$"%options".grab_focus()
