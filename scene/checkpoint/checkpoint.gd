extends Area2D
@onready var animation_tree: AnimationTree = $AnimationTree

var _boss_killed :bool  = false
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SIGNALHUB.on_boss_killed.connect(onbosskilled)
	pass # Replace with function body.

func onbosskilled()->void:
	_boss_killed = true
	pass


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open":
		set_deferred("monitoring",true)
	pass # Replace with function body.



func _on_area_entered(area: Area2D) -> void:
	print("Level Complete")
	pass # Replace with function body.
