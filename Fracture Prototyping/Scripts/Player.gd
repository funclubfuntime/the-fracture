extends KinematicBody2D

const TYPE = "PLAYER"
const UP = Vector2(0, -1)
const MAX_SPEED = 200
const ACCELERATION = 15
const AIR_ACCELERATION = 8
const GRAVITY = 30

var movedir = Vector2()
var motion = Vector2()
var knockdir = Vector2()
var health = 100

var hitstun = 0

var player_facing = "right"

var state = "moving"
var animation = "start"

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		player_facing = "right"
	if Input.is_action_pressed("ui_left"):
		player_facing = "left"
	
	controls_loop()
	movement_loop()
	attack_loop()

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	
	movedir.x = -int(LEFT) + int(RIGHT)

func movement_loop():
	if state == "moving":
		animation = "start"
		
		motion.y += GRAVITY
		
		if movedir.x > 0:
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.play("Run")
			$Sprite.flip_h = false
		elif movedir.x < 0:
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.play("Run")
			$Sprite.flip_h = true
		else:
			motion.x = lerp(motion.x, 0, 0.2)
			$Sprite.play("Idle")
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -500
		else:
			$Sprite.play("Jump")
		
		motion = move_and_slide(motion, UP)
		
		if Input.is_action_just_pressed("stab_atk"):
			state = "stab_1"
		if Input.is_action_just_pressed("slash_atk"):
			state = "slash_1"

func attack_loop():
	if state == "stab_1":
		motion.y = 0
		motion.y += GRAVITY
		$Sprite.play("Stab_1")
		if player_facing == "right":
			motion.x = 225
		else:
			motion.x = -225
		
		if animation == "fin":
			state = "moving"
		
		motion = move_and_slide(motion, UP)
	
	if state == "slash_1":
		motion.y = 0
		motion.y += GRAVITY
		$Sprite.play("Slash_1")
		if player_facing == "right":
			motion.x = max(motion.x, 50)
		else:
			motion.x = min(motion.x, -50)
		
		if animation == "fin":
			state = "moving"
		
		motion = move_and_slide(motion, UP)


func _on_Sprite_animation_finished():
	animation = "fin"
	pass # replace with function body