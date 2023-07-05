extends Number
class_name Product

@export var numbers: Array[Number]

func _present() -> int:
	var rv := 1
	for n in numbers:
		rv *= n.value
	return rv
