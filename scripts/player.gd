extends CharacterBody2D

@export var MOVING_SPEED:float = 10.0
@export var JUMPING_SPEED:float = 400.0 # px/s
@export var JUMPING_MAX_HEIGHT:float = 200.0 # px
var start_jumping_height = -1

func play_animation()->void:
	if velocity.y != 0:
		$animation.play("jumping")
	elif velocity.x != 0:
		$animation.play("moving")
	else:
		$animation.play("default")

func look_forward()->void:
	if Input.is_action_just_pressed("right"):
		$animation.flip_h = false
	elif Input.is_action_just_pressed("left"):
		$animation.flip_h = true

func move()->void:
	var dir = 0
	if Input.is_action_pressed("left"):
		dir = -1
	elif Input.is_action_pressed("right"):
		dir = 1
	
	velocity.x = dir * MOVING_SPEED

func jump()->void:
	if is_on_ceiling() or is_on_floor():
		Status.turn_off_state(Status.JUMPING)
	if Input.is_action_just_pressed("jump") and not Status.get_state(Status.JUMPING) and is_on_floor():
		Status.turn_on_state(Status.JUMPING)
		velocity.y = -JUMPING_SPEED
		
	if Status.get_state(Status.JUMPING):
		if start_jumping_height == -1:
			start_jumping_height = position.y
		var jumping_distance = start_jumping_height - position.y + JUMPING_MAX_HEIGHT
		if jumping_distance > JUMPING_MAX_HEIGHT:
			Status.turn_off_state(Status.JUMPING)
		else:
			velocity.y = -JUMPING_SPEED
	
func _process(_delta: float) -> void:
	move()
	jump()
	look_forward()
	play_animation()
	
func _physics_process(delta: float) -> void:
	falling_down(delta)
	move_and_slide()
	
func falling_down(delta:float) -> void:
	if not is_on_floor() and not Status.get_state(Status.JUMPING):
		velocity += get_gravity() * delta
