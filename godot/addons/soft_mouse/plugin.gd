@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("_MOUSE", "res://addons/soft_mouse/soft_mouse.tscn")


func _exit_tree():
	remove_autoload_singleton("_MOUSE")
