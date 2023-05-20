extends Node

var data = {}
const FILE = "user://init.txt"

var NAME = ProjectSettings["application/config/name"]
var POSITION = "window position %s" % NAME
var SIZE = "window size %s" % NAME
var MODE = "window mode %s" % NAME

func Save():
	data[MODE] = DisplayServer.window_get_mode()
	if data[MODE] == DisplayServer.WINDOW_MODE_WINDOWED:
		data[SIZE] = DisplayServer.window_get_size()
		data[POSITION] = DisplayServer.window_get_position()
	
	var file = FileAccess.open(FILE,FileAccess.WRITE)
	file.store_string(var_to_str(data))
	

signal loaded
var is_loaded := false

func Load():
	is_loaded = false
	if not FileAccess.file_exists(FILE): 
		Save()
		is_loaded = true
		emit_signal("loaded")
		return
	var sample_data = str_to_var(FileAccess.get_file_as_string(FILE))
	if sample_data is Dictionary: data = sample_data
	else : 
		is_loaded = true
		emit_signal("loaded")
		return
	
	if data.has(POSITION): DisplayServer.window_set_position(data[POSITION])
	if data.has(SIZE): DisplayServer.window_set_size(data[SIZE])
	if data.has(MODE): 
		await get_tree().process_frame
		DisplayServer.window_set_mode(data[MODE])

	is_loaded = true
	emit_signal("loaded")


func _ready():
	await get_tree().process_frame
	Load()
	if not is_loaded: await loaded
	Save()

func _process(delta):
	pass

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST or \
	what == NOTIFICATION_WM_SIZE_CHANGED:
		if not is_loaded: await loaded
		Save()
