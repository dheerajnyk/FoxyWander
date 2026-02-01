extends EnemyBase
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_frog: AnimatedSprite2D = $animatedFrog
@onready var jump_timer: Timer = $JumpTimer

var seen_player:bool = false
var can_jump:bool = false

#const GRAVITY = 800;
#const SPEED = 300.0
const FROG_JUMP_VELOCITY_R:Vector2 = Vector2(100,-150.0)
const FROG_JUMP_VELOCITY_L:Vector2 = Vector2(-100,-150.0)


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.y += _gravity * delta
	#velocity.x = speed if animated_frog.flip_h == true else -speed
	apply_jump()
	move_and_slide()
	flip_me()
	if is_on_floor()== true:
		velocity.x = 0
		animated_frog.play("FrogIdle")

func apply_jump()-> void:
	if is_on_floor() == false or can_jump == false:
		return 
	if seen_player == false:
		return
	velocity = FROG_JUMP_VELOCITY_R if animated_frog.flip_h else FROG_JUMP_VELOCITY_L
	can_jump= false
	start_timer()
	animated_frog.play("FrogJump")
	
func flip_me()-> void:
	animated_frog.flip_h = player_ref.global_position.x > global_position.x
	#if is_on_wall()== true or ray_cast_2d.is_colliding()==false:
		#animated_frog.flip_h = !animated_frog.flip_h
		#ray_cast_2d.position.x = -ray_cast_2d.position.x

func start_timer() ->void:
	jump_timer.wait_time = randf_range(2,3)
	jump_timer.start()

func _on_jump_timer_timeout() -> void:
	can_jump = true
	pass # Replace with function body.


func _on_2visible_on_screen_notifier_2d_screen_entered() -> void:
	if seen_player == false:
		seen_player = true
		start_timer()
	pass # Replace with function body.
