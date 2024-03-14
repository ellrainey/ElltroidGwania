extends CharacterBody2D


var SPEED = 300.0
const JUMP_VELOCITY = -550.0
var doubleJumpUsed = false
var timeSinceDash = 0
var dashCounting = false

var airSlideTL = false
var airSlideTR = false
var airSlideBL = false
var airSlideBR = false

var airSlideUsed = false
var timeSinceSlide = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	#handle double jump
	if is_on_floor():
		doubleJumpUsed = false
		airSlideUsed = false
		
		#dash, press tab to dash, (tab is ui_text_completion_replace)
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			if is_on_floor():
				if Input.is_action_just_pressed("ui_text_completion_replace") and  not dashCounting:
					dashCounting = true
					SPEED += 400
				
	print(dashCounting)
	if timeSinceDash > 0.25:
		SPEED = 300
		dashCounting = false
		timeSinceDash = 0
	if dashCounting:
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
	
	# handle airslide and movement
	if direction and not is_on_floor() and Input.is_action_just_pressed("ui_text_completion_replace") and not airSlideUsed:
		airSlideUsed = true
		if(direction > 0):
			if(Input.is_action_pressed("ui_up")):
				airSlideTR = true
			else:
				airSlideBR = true
		else:
			if(Input.is_action_pressed("ui_up")):
				airSlideTL = true
			else:
				airSlideBL = true
	elif direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
				

	#airslide end and direction handling
	if is_on_floor() or timeSinceSlide > 0.25:
		airSlideTL = false
		airSlideTR = false
		airSlideBL = false
		airSlideBR = false
		timeSinceSlide = 0
	if airSlideTL or airSlideTR or airSlideBL or airSlideBR:
		timeSinceSlide += delta
		if airSlideTL:
			velocity.y = -700
			velocity.x = -700
		elif airSlideTR:
			velocity.y = -700
			velocity.x = 700
		elif airSlideBL:
			velocity.y = 700
			velocity.x = -700
		elif airSlideBR:
			velocity.y = 700
			velocity.x = 700
	
	
		
	

	move_and_slide()
