@tool
extends EditorPlugin

const NAME = "_INIT"

func _enter_tree():
	add_autoload_singleton(NAME,"res://addons/basic_init/initializer.gd")

func _exit_tree():
	remove_autoload_singleton("_INIT")
