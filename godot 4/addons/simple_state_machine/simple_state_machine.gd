@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("StateMachine", "Node", preload("StateMachine.gd"),preload("fsmgears.svg"))
	add_custom_type("State", "Node", preload("state.gd"), preload("state gear.svg"))
	pass


func _exit_tree():
	remove_custom_type("StateMachine")
	remove_custom_type("State")
	pass
