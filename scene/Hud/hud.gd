extends Control
@onready var label: Label = $MarginContainer/Label

var _score:int = 0

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed("quit"):
		GameManager.load_main()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_score = GameManager.cached_score
	onscored(0)
	pass # Replace with function body.

func _enter_tree() -> void:
	SIGNALHUB.on_score.connect(onscored)
	
func _exit_tree() -> void:
	GameManager.try_add_new_score(_score)

func onscored(points:int) -> void:
	_score += points
	label.text = "%05d" % _score
