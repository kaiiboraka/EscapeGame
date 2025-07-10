extends CharacterBody2D

@export var moveSpeed := 200
@export var bulletScene : PackedScene
@export var dashSpeed := 1000
@export var dashDuration := 1.0
@export var dashCooldown := 2

var dashVector := Vector2.ZERO
var isDashing := false
var dashTimer : float = 0.0

func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float):
	var direction := Vector2.ZERO
		
	if not isDashing:
		direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		velocity = direction * moveSpeed
		if Input.is_action_just_pressed("dash") and $DashCooldown.is_stopped():
			start_dash(direction)
		
	else:
		velocity = dashVector * dashSpeed
		dashTimer -= delta
		print("Duration: ", dashTimer)
		if dashTimer <= 0:
			isDashing = false
			

	move_and_slide()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	if bulletScene:
		var bullet = bulletScene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = global_position
		bullet.rotation = (get_global_mouse_position() - global_position).angle()
		bullet.set_direction((get_global_mouse_position() - global_position).normalized())
	
func start_dash(direction: Vector2):
	if direction == Vector2.ZERO:
		return
	isDashing = true
	dashVector = direction
	dashTimer = dashDuration
	$DashCooldown.start()
	
	
	
