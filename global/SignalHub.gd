extends Node
#class_name SignalHub
signal on_createBullet(pos:Vector2,dir:Vector2,speed:float,Ob_type:Constants.ObjectType)
signal on_createObject(pos:Vector2,Ob_type:Constants.ObjectType)
signal on_score(points:int)
signal on_boss_killed

func  oncreateBullet(pos:Vector2,dir:Vector2,speed:float,Ob_type:Constants.ObjectType)->void:
	on_createBullet.emit(pos,dir,speed,Ob_type)


func  oncreateObject(pos:Vector2,Ob_type:Constants.ObjectType)->void:
	on_createObject.emit(pos,Ob_type)

func onscore(score:int)->void:
	on_score.emit(score)



func onbosskilled() -> void:
	on_boss_killed.emit()
