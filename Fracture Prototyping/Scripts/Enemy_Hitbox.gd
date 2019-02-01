extends Area2D

const MAX_HEALTH = 100

var current_health = 50
var stab_hurtbox = false
var slash_hurtbox = false
var player_facing_r = true
var player_facing_l = false

func _ready():
	current_health = MAX_HEALTH
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("ui_right"):
		player_facing_r = true
		player_facing_l = false
	if Input.is_action_just_pressed("ui_left"):
		player_facing_r = false
		player_facing_l = true
	
	if Input.is_action_just_pressed("stab_atk"):
		stab_hurtbox = true
		yield(get_tree().create_timer(0.1), "timeout")
		stab_hurtbox = false
	
	if Input.is_action_just_pressed("slash_atk"):
		slash_hurtbox = true
		yield(get_tree().create_timer(0.1), "timeout")
		slash_hurtbox = false
	
	pass

func _physics_process(delta):
	var bodies = get_overlapping_areas()
	for body in bodies:
		if body.name == "StabHbR":
			if player_facing_r == true:
				if stab_hurtbox == true:
					current_health = current_health - 10
		if body.name == "StabHbL":
			if player_facing_l == true:
				if stab_hurtbox == true:
					current_health = current_health - 10
		
		if body.name == "SlashHbR":
			if player_facing_r == true:
				if slash_hurtbox == true:
					current_health = current_health - 7
		if body.name == "SlashHbL":
			if player_facing_l == true:
				if slash_hurtbox == true:
					current_health = current_health - 7
	
	
	
	pass