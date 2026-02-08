extends VBoxContainer
class_name HighscoreDisplayItem
@onready var label: Label = $Label
@onready var label_2: Label = $Label2

var high_score:HighScore = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if high_score == null:
		queue_free()
	else:
		label.text = "%05d" % high_score.score
		label_2.text = high_score.date_scored
		run_tween()
	pass # Replace with function body.


func run_tween()->void:
	var tween:Tween = create_tween()
	tween.tween_property(self,"modulate",Color("#ffffff",1.0),0.8)
		

func setup(hs:HighScore):
	high_score = hs

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
