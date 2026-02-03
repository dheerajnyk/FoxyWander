extends Node2D
class_name  ShooterClass
@onready var shoot_timer: Timer = $ShootTimer
@onready var sound: AudioStreamPlayer2D = $Sound


@export var speed:float = 50
@export var shootdelay:float = 0.7
@export var bulle_key:Constants.ObjectType = Constants.ObjectType.BULLET_PLAYER

var canshoot: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shoot_timer.wait_time=shootdelay
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func shoot(direction:Vector2)->void:
	if canshoot == false:
		return
	canshoot = false
	SIGNALHUB.oncreateBullet(global_position,direction,speed,bulle_key)
	shoot_timer.start()

func _on_shoot_timer_timeout() -> void:
	canshoot = true
	pass # Replace with function body.
