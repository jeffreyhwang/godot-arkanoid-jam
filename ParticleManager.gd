extends Node

export (PackedScene) var particle
export (int) var queue_count = 8

var index = 0

func _ready():
	for _i in range(queue_count):
		add_child(particle.instance())
	print("child count: ", get_child_count())
		
func get_next_particle():
	print("attempting to get index # ", index)
	return get_child(index)
	
func trigger():
	print("current index: ", index)
	get_next_particle().restart()
	index = (index + 1) % queue_count
