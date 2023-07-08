extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BULLET_SPEED = 3000.0

var player
var direction
var distance_to_player
var can_shoot = true

#this function is called on initialization
func _ready():
	player = get_parent().find_child("Playercharacter")

#delta is the time between frames
func _physics_process(delta):
	#this creature moves towards the player and then shoots a projectile when within a certain range
	#find distance to player
	distance_to_player = (player.position - position).length()
	
	#find the unit vector towards the player
	#position is stored as a vector2, with values in its x and y variables, but
	# godot supports vector math so we can use that to find the direction
	direction =  (player.position - position).normalized()
	
	#flip sprite if player's X position is < monster's X position
	if (direction.x < 0 ):
		get_child(0).scale.x = -.25
	elif (direction.x > 0):
		get_child(0).scale.x = .25
	
	#if less than 80 pixels from the player:
	if distance_to_player < 80:
		#stop and start shooting
		
		#reset velocity to 0
		velocity = Vector2.ZERO
		
		#start animation for shooting if not already started
		if get_child(0).get_animation() != "atttack":
			get_child(0).set_animation("atttack")
		
		#this code makes it so that it only shoots once per frame of shooting
		if can_shoot and get_child(0).get_frame() == 1:
			can_shoot = false
			
			#creating a bullet code:
			# first, get the blueprints of the bullet and create an instance of it
			var bullet = preload("res://objects/EnemyHopperBullet.tscn").instantiate()
			
			#next, attach the instance to the parent node of this enemy
			get_parent().add_child(bullet)
			
			#make the bullet come from this enemy
			bullet.position = position
			
			#finally, set the velocity of the bullet to go towards the player
			# also rotate its sprite in the direction of the player
			bullet.speed = BULLET_SPEED
			bullet.direction = direction
			bullet.set_rotation(direction.angle())
			
		elif !can_shoot and get_child(0).get_frame() == 2:
			can_shoot = true;
		
		
	else:
		#approach player casually
		
		#reminder, use delta to calculate time between frames
		velocity = direction * SPEED * delta
		
		#this code actually causes the obejct to move using the velocity value set earlier
		move_and_slide()
		
		#start animation for walking, if not already started that
		# animatedsprite2d is the first object in the list of children so get_child(0) returns it
		if get_child(0).get_animation() != "walk":
			get_child(0).set_animation("walk")
