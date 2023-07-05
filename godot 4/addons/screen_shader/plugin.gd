@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("_SCREEN","res://addons/screen_shader/screen_shader.tscn")


func _exit_tree():
	remove_autoload_singleton("_SCREEN")
