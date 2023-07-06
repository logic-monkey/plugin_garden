tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("_OPT", "res://addons/basic_options/options.tscn")


func _exit_tree():
	remove_autoload_singleton("_OPT")
