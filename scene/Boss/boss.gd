extends Node2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var hitbox: Area2D = $Visuals/Hitbox
@onready var visuals: Node2D = $Visuals
@onready var shooter: ShooterClass = $Visuals/Shooter
@onready var sm: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@export var lives: int = 2
@export var points: int = 5

var player_ref: Player
var _invincible:bool = false
func _ready() -> void:
	player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)
	if(player_ref==null):
		queue_free()

func setinvinsible(x:bool)->void:
	_invincible = x
func shoot() -> void:
	shooter.shoot(
		shooter.global_position.direction_to(
			player_ref.global_position
		)
	)
	pass


func activate_collision()->void:
	hitbox.set_deferred("monitoring",true)
	hitbox.set_deferred("monitorable",true)

func reduce_life() -> void:
	lives -= 1
	if lives<=0:
		SIGNALHUB.onscore(points)
		SIGNALHUB.onbosskilled()
		queue_free()

func take_damage() -> void:
	if _invincible == true:
		return
	_invincible = true
	sm.travel("Hit")
	tween_hit()
	reduce_life()

func tween_hit() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(visuals,"position",Vector2.ZERO,1.8)


func _on_trigger_area_entered(area: Area2D) -> void:
	animation_tree["parameters/conditions/on_trigger"] = true
	pass # Replace with function body.


func _on_hitbox_area_entered(area: Area2D) -> void:
	take_damage()
	pass # Replace with function body.
