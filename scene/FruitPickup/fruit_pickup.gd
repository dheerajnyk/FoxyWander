extends Area2D

@export var points:int =2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ln:Array[String] = []
	for an_names in animated_sprite_2d.sprite_frames.get_animation_names():
		ln.append(an_names)
	
	animated_sprite_2d.animation = ln.pick_random()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	queue_free()
	pass # Replace with function body.
