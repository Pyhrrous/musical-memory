extends CharacterBody2D

var speed
var direction

func _physics_process(delta):
	velocity = speed * direction * delta
	move_and_slide()
