extends Node

@export var life_time:float = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(life_time).timeout
	get_parent().call_deferred("queue_free")
	pass # Replace with function body.
