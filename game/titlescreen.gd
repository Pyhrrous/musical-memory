extends Node2D

#1 for credits/instructions
#2 for black screen fadeout
var state = 0

func _physics_process(delta):
	if (state == 2):
		get_child(3).self_modulate.a += 2 * delta
		if get_child(3).self_modulate.a >= 1:
			get_tree().change_scene_to_file("res://gamespace.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			if (state == 0):
				if (event.position.x > 587/2 and event.position.y > 415/2 and event.position.x < 687/2 and event.position.y < 504/2):
					state = 2
				elif (event.position.x > 190/2 and event.position.y > 419/2 and event.position.x < 280/2 and event.position.y < 522/2):
					state = 1
					get_child(2).visible = true
				elif (event.position.x > 958/2 and event.position.y > 413/2 and event.position.x < 1055/2 and event.position.y < 519/2):
					state = 1
					get_child(1).visible = true
			elif (state == 1):
				print("Blerp")
				print(event.position.x, " ", event.position.y)
				if (event.position.x > 985/2 and event.position.y > 439/2 and event.position.x < 1058/2 and event.position.y < 504/2):
					print("two")
					state = 0
					get_child(1).visible = false
					get_child(2).visible = false
		
