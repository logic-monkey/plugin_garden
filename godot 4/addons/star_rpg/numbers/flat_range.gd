extends Number
class_name flat_range

@export var lower_bound := 1
@export var upper_bound := 10

var amount:= 0

func _init():
	amount = randi_range(lower_bound,upper_bound)
	
func _present() ->int:
	return amount
