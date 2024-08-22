extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func jump():
	velocity.y=JUMP_VELOCITY

func jump_side(x):
	velocity.y=JUMP_VELOCITY
	velocity.x=x

func _physics_process(delta: float) -> void:
	#Animations 
	if(velocity.x>1||velocity.x<-1):
		animated_sprite_2d.animation="running"
	else:
		animated_sprite_2d.animation="default_idle"

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation="jumping"
		if velocity.y>0:
			animated_sprite_2d.animation="fall"
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 20)

	move_and_slide()

	var isLeft = velocity.x<0
	animated_sprite_2d.flip_h=isLeft
