extends EnemyBase

@export var flyspeed:Vector2 = Vector2(35,15)
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var player_detect_ray: RayCast2D = $PlayerDetectRay
@onready var direction_timer: Timer = $DirectionTimer
@onready var shooter: Node2D = $Shooter

var fly_direction:Vector2 = Vector2.ZERO

func flytoplayer()->void:
	flip_me()
	var x_dir= 1 if animated_sprite_2d.flip_h else -1
	#fly_direction = (player_ref.global_position - global_position).normalized() * flyspeed
	fly_direction = Vector2(x_dir,1) * flyspeed
	pass
	
func shoot() -> void:
	if player_detect_ray.is_colliding() == true:
		shooter.shoot(global_position.direction_to(player_ref.global_position))
	pass

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity = fly_direction
	move_and_slide()
	shoot()
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	
func flip_me()-> void:
	animated_sprite_2d.flip_h = player_ref.global_position.x > global_position.x

func _on_direction_timer_timeout() -> void:
	flytoplayer()
	pass # Replace with function body.


func _on_2visible_on_screen_notifier_2d_screen_entered() -> void:
	if(animated_sprite_2d == null):
		return
	animated_sprite_2d.play("fly")
	direction_timer.start()
	flytoplayer()
	pass # Replace with function body.
