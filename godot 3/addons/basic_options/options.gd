extends CanvasLayer

export(Array, PackedScene) var screens

var pause_cache := false

const TIME_TO_FADE = 0.25
signal options_done
func dismiss():
	_IMP.mode = _IMP.TRANSITION
	var tween = get_tree().create_tween()
	tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($fade,"modulate",Color.transparent,TIME_TO_FADE)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	yield(tween,"finished")
	visible = false
	get_tree().paused = pause_cache
	_IMP.pop()
	emit_signal("options_done")
	
func summon(title:bool=false):
	$"%title".visible = not title
	_IMP.push(_IMP.TRANSITION)
	visible = true
	$"%back".grab_focus()
	pause_cache = get_tree().paused
	get_tree().paused = true
	var tween = get_tree().create_tween()
	tween.set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS)
	tween.tween_property($fade,"modulate",Color.white,TIME_TO_FADE)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	yield(tween,"finished")
	_IMP.mode = _IMP.MENU


func _on_back_pressed():
	dismiss()

func _on_title_pressed():
	dismiss()
	yield(self, "options_done")
	_FADER.FadeTo("res://addons/pixel_art/pixel_title.tscn")
	

func _on_exit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
	
func _ready():
	$fade.modulate = Color.transparent
	visible = false
	for scene in screens:
		var sc = scene.instance()
		$"%TabContainer".add_child(sc)
