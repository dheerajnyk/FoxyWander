extends EnemyBase
@onready var ray_cast_2d: RayCast2D = $RayCast2D

#const GRAVITY = 800;
#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.y += _gravity * delta
	velocity.x = speed if animated_sprite_2d.flip_h == true else -speed
	move_and_slide()
	flip_me()


func flip_me()-> void:
	if is_on_wall()== true or ray_cast_2d.is_colliding()==false:
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
		ray_cast_2d.position.x = -ray_cast_2d.position.x
