extends StaticBody2D

var health = 2
onready var sprite = $Sprite
onready var animation = $AnimationPlayer
# Declare member variables here. Examples:

# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = Color(1, 0, 0)
	
func _process(delta):
	if (health == 1):
		animation.play("Pulsate")
		sprite.modulate = Color("ff6f6f")
	if (health < 1):
		queue_free()




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
