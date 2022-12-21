extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera = $Camera2D
onready var particle_manager = $ParticleManager
onready var reset_timer = $ResetTimer
onready var paddle = $Paddle
var rand = RandomNumberGenerator.new()
var RANDOM_SHAKE_STRENGTH = 10
var SHAKE_DECAY = 4
var shake = 0
var ball = load("res://Ball.tscn")
var spawn_location = Vector2(320, 800)
var lives = 3
onready var life_label = $LivesLabel

func _unhandled_input(event):
	if event is InputEventScreenTouch and event.pressed == true:
		if (event.position.x < get_viewport().get_rect().size.width):
			paddle.direction.x = -1
		else:
			paddle.direction.x = 1
	else:
		paddle.direction.x = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	rand.randomize()
	Event.connect("ball_hit_brick", self, "_on_Ball_hit_brick")
	Event.connect("ball_hit_wall", self, "_on_Ball_hit_wall")
	Event.connect("ball_hit_paddle", self, "_on_Ball_hit_paddle")
	Event.connect("ball_in_deadzone", self, "_on_Ball_in_deadzone")
	life_label.text = "Life: " + str(lives)
	var new_ball = ball.instance()
	new_ball.global_position = spawn_location
	add_child(new_ball)
	reset_timer.start()
	yield(reset_timer, "timeout")
	new_ball.start()
	life_label.ALIGN_CENTER


func _process(delta):
	shake = lerp(shake, 0, SHAKE_DECAY * delta)
	camera.offset = get_random_offset()

func _physics_process(delta):
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Ball_hit_brick(brick_name):
	print("ball hit brick with name: ", brick_name)
	var brick = get_node(brick_name)
	particle_manager.get_next_particle().global_position = brick.position
	particle_manager.trigger()
	brick.health -= 1

func _on_Ball_hit_wall():
	print("on_ball_hit_wall")
	
func _on_Ball_hit_paddle():
	shake = RANDOM_SHAKE_STRENGTH
	
func get_random_offset():
	return Vector2(rand.randf_range(-shake, shake), rand.randf_range(-shake, shake))

func _on_Ball_in_deadzone():
	lives -= 1
	if (lives < 1):
		get_tree().change_scene("res://TitleScreen.tscn")
	life_label.text = "Life: " + str(lives)
	var new_ball = ball.instance()
	new_ball.global_position = spawn_location
	add_child(new_ball)
	reset_timer.start()
	yield(reset_timer, "timeout")
	new_ball.start()

func _on_Area2D_body_entered(body):
	print("body entered to dead zone: ", body.name)
	Event.emit_signal("ball_in_deadzone")

		
