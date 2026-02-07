extends CharacterBody2D
class_name Player
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@export var felloff_y :float= 1000.0
const SPEED = 120.0
const JUMP_VELOCITY = -600.0
const GRAVITY :float = 690
const MAXFALL :float = 350.0 
const HURT_JUMP_VELOCITY:Vector2 = Vector2(0,-130)
const PLAYER = preload("uid://co1njq46con5c")
const LEVEL_BASE = preload("uid://depgaj4slkg3v")
@onready var shooter: Node2D = $Shooter
@onready var sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer
const JUMP = preload("uid://bad3wtat26y8g")
const DAMAGE = preload("uid://bt0i2tyyb5fdx")
var _invincible:bool = false
var _is_hurt:bool = false

func play_effect(effect:AudioStream)->void:
	sound.stop()
	sound.stream = effect
	sound.play()
	

func get_inputs() -> void:
	## Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		play_effect(JUMP)
		velocity.y = JUMP_VELOCITY
	pass

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
	
	get_inputs()
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

func apply_hurt_jump() ->void:
	_is_hurt = true
	velocity = HURT_JUMP_VELOCITY
	play_effect(DAMAGE)
	timer.start()

func go_invincible() ->void:
	if _invincible == true:
		return
	_invincible = true	
	var tween:Tween = create_tween()
	for i in range(3):
		tween.tween_property(sprite_2d,"modulate",Color("#ffffff",0),0.5)
		tween.tween_property(sprite_2d,"modulate",Color("#ffffff",1),0.5)
	tween.tween_property(self,"_invincible",false,0)

func apply_hit()->void:
	if _invincible == true:
		return;
	go_invincible()
	apply_hurt_jump()

func _on_hitbox_area_entered(area: Area2D) -> void:
	call_deferred("apply_hit")
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	_is_hurt= false
	
	pass # Replace with function body.
