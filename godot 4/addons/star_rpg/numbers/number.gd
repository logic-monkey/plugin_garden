@icon("res://addons/star_rpg/numbers/octothorpe.svg")
extends Resource
class_name Number

var val: int
@export var value : int:
	get:
		return _present()
	set(v): 
		val = v
		
func _present() -> int:
	return val
