extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var PADDLE_SPEED = 500
var direction = Vector2.ZERO
onready var sprite = $Sprite
onready var collision_shape = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	pass

func _process(delta):
	if Input.is_action_pressed("paddle_left"):
		direction.x = -1
	elif Input.is_action_pressed("paddle_right"):
		direction.x = 1
	else:
		direction.x = 0

func _physics_process(delta):
	move_and_collide(direction * PADDLE_SPEED * delta)
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
