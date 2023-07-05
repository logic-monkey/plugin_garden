@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("_STARPG", "res://addons/star_rpg/starpg_combat.tscn")


func _exit_tree():
	remove_autoload_singleton("_STARPG")
