extends Node2D




const OBJECT_SCENES:Dictionary[Constants.ObjectType,PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER:preload("res://scene/Bullet/player_bullet.tscn"),
	Constants.ObjectType.BULLET_ENEMY : preload("res://scene/Bullet/enemy_bullet.tscn"),
	Constants.ObjectType.PIKUP : preload("res://scene/FruitPickup/fruit_pickup.tscn")
}


# Called when the node enters the scene tree for the first time.
func _enter_tree() -> void:
	SIGNALHUB.on_createBullet.connect(oncreatebullet)
	SIGNALHUB.on_createObject.connect(on_createObject)

	pass # Replace with function body.

func oncreatebullet(pos:Vector2,dir:Vector2,speed:float,Ob_type:Constants.ObjectType) -> void:
	if OBJECT_SCENES.has(Ob_type) == false:
		return
	
	var nb:Bullet = OBJECT_SCENES[Ob_type].instantiate()
	nb.setup(pos,dir,speed)
	call_deferred("add_child",nb)
	pass
	
func on_createObject(pos:Vector2,Ob_type:Constants.ObjectType) -> void:
	if OBJECT_SCENES.has(Ob_type) == false:
		return
	
	var nb:Node2D = OBJECT_SCENES[Ob_type].instantiate()
	nb.global_position = pos
	call_deferred("add_child",nb)
	pass
