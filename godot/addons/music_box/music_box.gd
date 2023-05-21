@icon("musicbox.svg")
extends AudioStreamPlayer
class_name MusicBox

signal song_loaded
func LoadDisc(song : String):
	if not ResourceLoader.exists(song):
		emit_signal("song_loaded")
		return
	ResourceLoader.load_threaded_request(song, "AudioStream")
	var tree = get_tree()
	while ResourceLoader.load_threaded_get_status(song) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		await tree.process_frame
	var status = ResourceLoader.load_threaded_get_status(song)
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		%disc.song = ResourceLoader.load_threaded_get(song)
	else:
		%disc.song = null
	emit_signal("song_loaded")
	return

signal faded_out
func FadeMusicOut(time := 0.25):
	var tween = get_tree().create_tween()
	tween.tween_method(SetFadeVolume,1,0, time).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	await tween.finished
	emit_signal("faded_out")
	
func SetFadeVolume(v:float):
	v = clampf(v, 0, 1)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("music box"),linear_to_db(v))
	
func SwitchToSong(song,fade_time:float=0.0):
	if song is String:
		if song == stream.resource_path: return
		LoadDisc(song)
		await song_loaded
		if %disc.song == null: return
	elif song is AudioStream:
		if song == stream: return
		%disc.song = song
	else:
		return
	if fade_time > 0.01:
		FadeMusicOut(fade_time)
		await faded_out
	stop()
	SetFadeVolume(1)
	stream = %disc.song
	play()
	
	
