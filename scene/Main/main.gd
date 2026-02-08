extends Control
@onready var grid_container: GridContainer = $MarginContainer/GridContainer
const VBOX = preload("uid://bspck7h5t3kh4")


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("shoot"):
		GameManager.load_next_level()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_scores()
	pass # Replace with function body.

func set_scores()-> void:
	for score: HighScore in GameManager.high_scores.get_scores_list():
		var hsd:HighscoreDisplayItem = VBOX.instantiate()
		hsd.setup(score)
		grid_container.add_child(hsd)
