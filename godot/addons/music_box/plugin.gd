@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("_MUSIC","res://addons/music_box/music_box.tscn")


func _exit_tree():
	remove_autoload_singleton("_MUSIC")
