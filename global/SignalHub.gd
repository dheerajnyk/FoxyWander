extends Node
#class_name SignalHub
signal on_createBullet(pos:Vector2,dir:Vector2,speed:float,Ob_type:Constants.ObjectType)
signal on_createObject(pos:Vector2,Ob_type:Constants.ObjectType)

func  oncreateBullet(pos:Vector2,dir:Vector2,speed:float,Ob_type:Constants.ObjectType)->void:
	on_createBullet.emit(pos,dir,speed,Ob_type)


func  oncreateObject(pos:Vector2,Ob_type:Constants.ObjectType)->void:
	on_createObject.emit(pos,Ob_type)
