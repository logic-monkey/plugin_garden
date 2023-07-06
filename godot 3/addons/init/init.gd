extends Node

var data = {}
export var GameID = "game"
onready var FILE = "user://%s init.txt" % GameID

const POSITION = "window position"
const SIZE = "window size"
const  MAXIMIZED = "window maximized"
const FULLSCREEN = "game fullscreen"

func Save():
	data[MAXIMIZED] = OS.window_maximized
	if not data[MAXIMIZED] and \
			(not FULLSCREEN in data or not data[FULLSCREEN]):
		data[SIZE] = OS.window_size
		data[POSITION] = OS.window_position
	var file = File.new()
	file.open(FILE, File.WRITE)
	file.store_string(var2str(data))
	file.close()

signal loaded
var is_loaded := false
func Load():
	is_loaded = false
	var file = File.new()
	if not file.file_exists(FILE):
		Save()
		is_loaded = true
		emit_signal("loaded")
		return
	file.open(FILE, File.READ)
	var sample_data = str2var(file.get_as_text())
	file.close()
	if sample_data is Dictionary: data = sample_data
	else:
		is_loaded = true
		emit_signal("loaded")
		return
#	call_deferred("_set_props")
	_set_props()
	is_loaded = true
	emit_signal("loaded")
	return
	
func _set_props():
	if POSITION in data: OS.window_position = data[POSITION]
	if SIZE in data: OS.window_size = data[SIZE]
	if MAXIMIZED in data: OS.window_maximized = data[MAXIMIZED]
	
func _ready():
	yield(get_tree(),"idle_frame")
	Load()
	if not is_loaded: yield(self, "loaded")
	Save()
	get_viewport().connect("size_changed", self, "_on_vp_resize")
	
func _notification(what):
	if what == NOTIFICATION_WM_QUIT_REQUEST:
		if not is_loaded: yield(self, "loaded")
		Save()

func _on_vp_resize():
	if not is_loaded: yield(self, "loaded")
	Save()
