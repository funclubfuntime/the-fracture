extends KinematicBody2D

onready var node = get_node("EnemyHitbox")
onready var player = get_parent().get_node("Player")

const TYPE = "ENEMY"
const UP = Vector2(0, -1)
const MAX_ENEMY_SPEED = 75
const ENEMY_ACCELERATION = 15
const DAMAGE = 1

var follow = false
var distance
var direction = Vector2()
var knockdir = Vector2()

var hitstun = 0

var react_time = 480
var dir = 0
var next_dir = 0
var next_dir_time = 0

var enemy_state = "moving"

var motion = Vector2()

func _process(delta):
	detect_hurtbox()

func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec() + react_time

func _physics_process(delta):
	motion.y += 30
	
	if player.position.x < position.x:
		set_dir(-1)
		$icon.flip_h = false
	elif player.position.x > position.x:
		set_dir(1)
		$icon.flip_h = true
	else:
		set_dir(0)
	
	if enemy_state == "moving":
		if OS.get_ticks_msec() > next_dir_time:
			dir = next_dir
		
		if is_on_wall():
			motion.y = -450
		
		if dir == -1:
			motion.x = max(motion.x - ENEMY_ACCELERATION, -MAX_ENEMY_SPEED)
		elif dir == 1:
			motion.x = min(motion.x + ENEMY_ACCELERATION, MAX_ENEMY_SPEED)
		else:
			motion.x = lerp(motion.x, 0, 0.2)
		
		motion = move_and_slide(motion, UP)
		
		if node.current_health <= 0:
			self.queue_free()
		pass

func detect_hurtbox():
	var player_state = get_parent().get_node("Player").get("state")
	
	for body in node.get_overlapping_areas():
		if body.name == "StabHbL":
			if node.player_facing_l == true:
				if player_state == "stab_1":
					enemy_state == "hit"
					node.current_health -= 10
					motion.x = lerp(-100, 0, 0.2)
					enemy_state == "moving"
		if body.name == "StabHbR":
			if node.player_facing_r == true:
				if player_state == "stab_1":
					enemy_state == "hit"
					node.current_health -= 10
					motion.x = lerp(100, 0, 0.2)
					enemy_state == "moving"
		
		if body.name == "SlashHbL":
			if node.player_facing_l == true:
				if player_state == "slash_1":
					enemy_state = "hit"
					node.current_health -= 10
					motion.x = lerp(-100, 0, 0.2)
					enemy_state = "moving"
		if body.name == "SlashHbR":
			if node.player_facing_r == true:
				if player_state == "slash_1":
					enemy_state = "hit"
					node.current_health -= 10
					motion.x = lerp(100, 0, 0.2)
					enemy_state = "moving"
		
		if body.name == "Stab_2HbL":
			if node.player_facing_l == true:
				if player_state == "stab_2":
					enemy_state = "hit"
					node.current_health -= 10
					motion.x = lerp(-100, 0, 0.2)
					enemy_state = "moving"
		if body.name == "Stab_2HbR":
			if node.player_facing_r == true:
				if player_state == "stab_2":
					enemy_state = "hit"
					node.current_health -= 10
					motion.x = lerp(100, 0, 0.2)
					enemy_state = "moving"
	
	motion = move_and_slide(motion,UP)