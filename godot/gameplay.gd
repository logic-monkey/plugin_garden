extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	_IMP.input_mode_changed.connect(on_input_mode_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("vp_start") or Input.is_action_just_pressed("vp_back")) and \
			_IMP.mode == _IMP.EXPLORE:
				_OPTIONS.summon()

func on_input_mode_changed(mode):
	if mode == _IMP.WAITING:
		_IMP.mode = _IMP.EXPLORE
