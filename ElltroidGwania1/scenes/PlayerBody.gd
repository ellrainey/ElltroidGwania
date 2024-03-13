extends CharacterBody2D


var SPEED = 300.0
const JUMP_VELOCITY = -400.0
var doubleJumpUsed = false
var timeSinceDash = 0
var dashCounting = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if is_on_floor():
		doubleJumpUsed = false
		
		#dash, press tab to dash, (tab is ui_text_completion_replace)
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			if Input.is_action_just_pressed("ui_text_completion_replace") and  not dashCounting:
				dashCounting = true
				SPEED += 400
	
	print(dashCounting)
	
	if timeSinceDash > 1:
		SPEED = 300
		dashCounting = false
		timeSinceDash = 0
	if dashCounting:
		SPEED += 25
		timeSinceDash += delta
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
 
	
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	elif  Input.is_action_just_pressed("ui_accept") and not doubleJumpUsed:
		velocity.y = JUMP_VELOCITY
		doubleJumpUsed = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
