extends Node
class_name State, "state gear.svg"

var state_machine

func enter(_msg: Dictionary = {}):
	pass

func proc(_delta: float):
	pass

func phys(_delta: float):
	pass

func exit():
	pass

func transition(state_name: String, msg: Dictionary = {}):
	state_machine.transition(state_name, msg)
