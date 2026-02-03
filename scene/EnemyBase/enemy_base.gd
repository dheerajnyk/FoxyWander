extends CharacterBody2D
class_name EnemyBase
@export var speed = 30
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const FALL_OF_Y:int = 200
const _gravity:float =  800
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_ref : Player

func _ready() -> void:
	player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)
	if(player_ref==null):
		queue_free()
	
func _physics_process(delta: float) -> void:
	if global_position.y >FALL_OF_Y:
		queue_free()

func die()-> void:
	set_physics_process(false)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	pass # Replace with function body.


func _on_hit_box_area_entered(area: Area2D) -> void:
	die()
	pass # Replace with function body.
