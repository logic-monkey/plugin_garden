extends Number
class_name xD6

@export var number_of_dice:=2
var dice :=0

func _init():
	for i in number_of_dice:
		dice += randi_range(1,6)
		
func _present() -> int:
	return dice
