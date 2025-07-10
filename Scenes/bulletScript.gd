extends Area2D

@export var speed = 1000
var direction := Vector2.ZERO

func set_direction(dir: Vector2):
	direction = dir
	
func _physics_process(delta):
	position += direction * speed * delta
	
	#if not get_viewport_rect().has_point(global_position):
		#queue_free()
		
func _on_body_entered(body):
	if body.name == "Player":
		return
		#bullet hitting something logic here
		#if WALL die
		#if Enemy deal damage
	
