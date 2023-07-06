extends Control

func _ready():
	if _FADER.fading: yield(_FADER,"faded_in")
	_IMP.mode = _IMP.EXPLORE
	_IMP.connect("imp_mode_changed", self,"_on_imp_mode_changed")

func _process(_delta):
	if _IMP.mode != _IMP.EXPLORE: return
	if Input.is_action_just_pressed("vp_start") or\
			Input.is_action_just_pressed("ui_cancel"):
		_OPT.summon()

func _on_imp_mode_changed(mode):
	if mode == _IMP.WAITING: _IMP.mode = _IMP.EXPLORE
