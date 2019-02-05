extends Area2D

const MAX_HEALTH = 1000

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
	
	pass