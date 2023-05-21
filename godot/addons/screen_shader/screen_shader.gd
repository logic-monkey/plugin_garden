extends CanvasLayer
var NAME = ProjectSettings["application/config/name"]

var CB_MODE = "colorblind mode %s" % NAME
var CB_INTENSITY = "colorblind intensity %s" % NAME

# Called when the node enters the scene tree for the first time.
func _ready():
	_OPTIONS.colorblind_changed.connect(_on_colorblind_filter_changed)


func _on_colorblind_filter_changed():
	if _INIT.data.has(CB_MODE):
		%screen.material.set_shader_parameter("colorblind_mode", _INIT.data[CB_MODE])
	if _INIT.data.has(CB_INTENSITY):
		%screen.material.set_shader_parameter("intensity", _INIT.data[CB_INTENSITY])
	
