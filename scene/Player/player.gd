extends CharacterBody2D
class_name Player
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@export var felloff_y :float= 1000.0
const SPEED = 120.0
const JUMP_VELOCITY = -600.0
const GRAVITY :float = 690
const MAXFALL :float = 350.0 
const PLAYER = preload("uid://co1njq46con5c")
const LEVEL_BASE = preload("uid://depgaj4slkg3v")
@onready var shooter: Node2D = $Shooter

func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("shoot")==true:
		var dir = Vector2.LEFT if sprite_2d.flip_h else Vector2.RIGHT
		shooter.shoot(dir)

func _physics_process(delta: float) -> void:
	## Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
#
	## Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if not is_equal_approx(velocity.x,0.0):
		sprite_2d.flip_h = velocity.x <0 
	#move_and_slide()
	velocity.y += GRAVITY * delta
	velocity.y = clampf(velocity.y,JUMP_VELOCITY,MAXFALL)
	move_and_slide()
	updatedebuglabel()
	if global_position.y > felloff_y:
		queue_free()
		queue_redraw()



func updatedebuglabel()->void:
	var ds = ""
	ds += "Floor: %s"%[is_on_floor()]
	ds += "\nVelocity: %.1f,%.1f"%[velocity.x,velocity.y]
	label.text = ds
