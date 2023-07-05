@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("_OPTIONS", "res://addons/options_screen/options.tscn")


func _exit_tree():
	remove_autoload_singleton("_OPTIONS")
