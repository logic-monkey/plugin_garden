extends CanvasLayer

export var time_to_fade := 0.25

func _ready():
	pass # Replace with function body.

signal faded_out
signal faded_in

func FadeOut():
	$color.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property($color, "modulate", Color.white, time_to_fade)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	yield(tween, "finished")
	emit_signal("faded_out")

func FadeIn():
	var tween = get_tree().create_tween()
	tween.tween_property($color, "modulate", Color.transparent, time_to_fade)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	yield(tween, "finished")
	$color.visible = false
	emit_signal("faded_in")
	
signal scene_changed
func FadeTo(scene):
	var tree = get_tree()
	FadeOut()
	yield(self, "faded_out")
	yield(tree, "idle_frame")
	tree.change_scene(scene)
	yield(tree, "idle_frame")
	emit_signal("scene_changed")
	FadeIn()
	yield(self, "faded_in")
	
