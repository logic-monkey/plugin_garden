@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("_FADE", "res://addons/scene_fader/fader.tscn")


func _exit_tree():
	remove_autoload_singleton("_FADE")
