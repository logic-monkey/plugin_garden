extends Node
class_name StateMachine, "fsmgears.svg"

export var initial_state: NodePath
var current
var _map: Dictionary = {}
func _ready():
	if Engine.is_editor_hint(): return
	for child in get_children():
		if child is State:
			if not initial_state: initial_state = child
			child.state_machine = self
			_map[child.name] = child
	current = get_node(initial_state)
	current.enter()
		
func _process(delta):
	if Engine.is_editor_hint(): return
	if current: current.proc(delta)
	
func _physics_process(delta):
	if Engine.is_editor_hint(): return
	if current: current.phys(delta)

func transition(state_name: String, args: Dictionary = {}):
	current.exit()
	current = _map[state_name]
	current.enter(args)
