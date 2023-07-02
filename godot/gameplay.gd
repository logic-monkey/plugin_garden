extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("hook_up")

func hook_up():
	_IMP.input_mode_changed.connect(on_input_mode_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _IMP.mode != _IMP.EXPLORE: return
	if Input.is_action_just_pressed("vp_start"): 
#			or Input.is_action_just_pressed("vp_back"):
		_OPTIONS.summon()

func on_input_mode_changed(mode):
	if mode == _IMP.WAITING:
		_IMP.mode = _IMP.EXPLORE
