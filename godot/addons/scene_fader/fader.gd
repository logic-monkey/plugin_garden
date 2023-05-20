extends CanvasLayer

@export var time_to_fade = 0.25

func _ready():
	FadeIn()

signal faded_out
signal faded_in

func FadeOut():
	visible = true
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "color", Color.BLACK, time_to_fade)\
	.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	emit_signal("faded_out")
	
func FadeIn():
	var tween = get_tree().create_tween()
	tween.tween_property($ColorRect, "color", Color.TRANSPARENT, time_to_fade)\
	.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	visible = false
	emit_signal("faded_in")
	
signal scene_changed
func FadeTo(scene):
	var tree = get_tree()
	FadeOut()
	await faded_out
	await tree.process_frame
	tree.change_scene_to_file(scene)
	await tree.process_frame
	emit_signal("scene_changed")
	FadeIn()
