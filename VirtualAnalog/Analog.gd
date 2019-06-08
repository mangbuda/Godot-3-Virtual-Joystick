extends Node2D

# Virtual Joystick
# Author : Komang Buda Artha
#License:  You're free to use these game in any project, personal or commercial. 
#There's no need to ask permission before using these. 
#Giving attribution is not required, but is greatly appreciated!

# For any Question :
# Youtube : https://www.youtube.com/channel/UCMif1Mgqy-8tgiiByFlqg6w
# FB : https://www.facebook.com/mang.buda.9

# You can scaling controller using this variabel 
export var SCALE = 1

#Parameter Output, You can use this variabel to read the Joystick output
var IsTouched = false # Flag if Joystick are touched or not
var Angle = 0 # The Angle (degre) Bettwen center of the Joystick and button
var Strength = 0 # Paramater how far button are touched, value(0-1)

var Radius = 70
var MousePos = Vector2()
var MobileMode = false
var TouchPos = Vector2()
var InIndex = -1

func _ready():
	Radius = Radius * SCALE
	$Radius.scale = Vector2(SCALE,SCALE)
	$Button.scale = Vector2(SCALE,SCALE)

	pass
	
func _process(delta):
	MousePos=get_global_mouse_position()
	
	if IsTouched == false:
		$Button.position = Vector2(0,0)
		InIndex = -1
	else:
		Angle = 90-rad2deg(MousePos.angle_to_point(position))
		if(MobileMode):
			Angle = 90-rad2deg(TouchPos.angle_to_point(position))
		
		if global_position.distance_to(MousePos)<Radius and MobileMode==false:
			$Button.global_position = MousePos
		elif global_position.distance_to(TouchPos)<Radius and MobileMode==true:
			$Button.global_position = TouchPos
		else:
			
			var Offside = Vector2(sin(deg2rad(Angle)),cos(deg2rad(Angle)))*Radius
			$Button.global_position = global_position+Offside
			pass
	Strength = position.distance_to($Button.global_position)/Radius
	
	$Label.text=str(" TouchPos"+str(TouchPos)+"\n MousePos"+str(MousePos)+"\n Strength : "+str(Strength)+"\n Angle : "+str(Angle) +"\n IsTouched : "+str(IsTouched))

	

func _input(event):
	if event is InputEventMouseButton :
		if event.is_pressed():
			if global_position.distance_to(MousePos)<Radius:
				IsTouched = true
			else:
				IsTouched = false
		else:
			IsTouched = false
	elif event is InputEventScreenTouch:
		var TouchPosTmp = get_canvas_transform().xform_inv(event.position)
		if event.is_pressed():
			if global_position.distance_to(TouchPosTmp)<Radius:
				IsTouched = true
				MobileMode = true
				if(InIndex == -1):
					InIndex = event.index
#		else:
#			TouchPos = Vector2()
#			MobileMode = false
#			IsTouched = false
	elif event is InputEventScreenDrag:
			if(InIndex==event.index):
				TouchPos = get_canvas_transform().xform_inv(event.position)
	pass
