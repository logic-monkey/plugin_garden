extends Number
class_name Sum

@export var addends: Array[Number]

func _present() -> int:
	var rv := 0
	for a in addends:
		rv+= a.value
	return rv
