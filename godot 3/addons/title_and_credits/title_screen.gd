extends Control

func _ready():
	_FADER.FadeIn()
	$"%start".grab_focus()
	


func _on_exit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_start_pressed():
	_FADER.FadeTo("res://gameplay.tscn")
