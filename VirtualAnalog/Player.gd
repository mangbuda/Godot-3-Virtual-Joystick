extends KinematicBody2D

const MAX_SPEED = 5

var Move = Vector2()


func _ready():

	pass

func _process(delta):
	var Analog = $CanvasLayer/Analog
	
	#on analog schene weare add formula 90-rad2deg(TouchPos.angle_to_point(position))
	# then if we are want to give them back to Radian just add this formual Radian = (Angle - 90)*-1
	 
	Move = Vector2(cos(-deg2rad(Analog.Angle-90)),sin(-deg2rad(Analog.Angle-90)))*Analog.Strength*MAX_SPEED
	
	rotation = deg2rad(-Analog.Angle)
	
	move_and_collide(Move)
	pass
