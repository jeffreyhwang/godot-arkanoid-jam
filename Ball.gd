extends KinematicBody2D

var speed = 600
var velocity :Vector2 setget set_velocity, get_velocity
onready var sprite = $Sprite


func _ready():
	pass

func start():
	set_velocity(Vector2(0, speed))

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	sprite.rotate(velocity.x * delta / 100)
	if collision:
		print("I collided with ", collision.collider.name, " with id", collision.collider_id)
		if collision.collider.name == "Wall":
			velocity = velocity.bounce(collision.normal)
			Event.emit_signal("ball_hit_wall")
		elif collision.collider.name == "Paddle":
			var relative_collision_to_center = collision.position.x - collision.collider.position.x
			var distance_from_center = relative_collision_to_center / (128 / 2)
			var angle = distance_from_center * 75 + 180
			var radians = angle * PI / 180
			velocity.y = speed * cos(radians)
			velocity.x = -speed * sin(radians)
			Event.emit_signal("ball_hit_paddle")
		else:
			velocity = velocity.bounce(collision.normal)
			Event.emit_signal("ball_hit_brick", collision.collider.name)
	if abs(velocity.y) < 130:
		velocity.y = sign(velocity.y) * 130
		

func set_velocity(v):
	velocity.x = v.x
	velocity.y = v.y

func get_velocity():
	pass
