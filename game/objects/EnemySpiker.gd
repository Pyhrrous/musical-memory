extends CharacterBody2D


const SPEED = 220.0
const JUMP_VELOCITY = -400.0

var player
var direction
var distance_to_player
var spiking = false

# Called on initialization
func _ready():
	player = get_parent().find_child("Playercharacter")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#find distance to player
	distance_to_player = (player.position - position).length()
	
	#find the unit vector towards the player
	direction =  (player.position - position).normalized()
	
	#flip sprite if player's X position is < monster's X position
	if (direction.x < 0 ):
		get_child(0).scale.x = -.25
	elif (direction.x > 0):
		get_child(0).scale.x = .25
	
	# If far away, slowly walk up to the player.
	if (distance_to_player > 40):
		if (spiking): # stop attacking
			spiking = false
		velocity = direction * SPEED * delta
		# set walking animation
		if (get_child(0).get_animation() != "walk"):
			get_child(0).set_animation("walk")
		
		move_and_slide()
		# add code for walk animation once i add it
	else: # Assumes it's near player. Become hazardous
		if (get_child(0).get_animation() != "attack"):
			get_child(0).set_animation("attack")
		spiking = true
