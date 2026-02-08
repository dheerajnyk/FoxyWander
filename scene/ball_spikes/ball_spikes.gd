extends PathFollow2D

@export var speed:float = 50
@export var spin_speed:float = 360
#var rotational_degree
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += speed * delta
	rotation_degrees += spin_speed *delta
	#rotational_degree += delta * speed
	pass
