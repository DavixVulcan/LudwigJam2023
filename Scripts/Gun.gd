extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = Vector2.RIGHT
var bullet = preload("res://Scenes/Bullet.tscn")
var marble = preload("res://Scenes/Marble.tscn")
var bullet_speed = 5
var damage = 1
onready var Icon = $Icon
onready var Anim = $AnimationPlayer
onready var Diag = $GunDiag
onready var pew = $GunPew
var marbling = 0
var rng = RandomNumberGenerator.new()
var last_dir = "Right"
var main_offset = 0
var diag_offset = 0
var youtube = false
var inner_up = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Anim.play("Idle")

func upgrade_to_youtube():
	if youtube == false:
		main_offset = 2
		diag_offset = 4
		youtube = true
		inner_up = false
	
func upgrade_inner():
	if inner_up == false:
		main_offset += 1
		diag_offset += 2
		inner_up = true
		damage += 20


func set_flips(diry):
	if diry:
		Icon.set_flip_h(true)
		Diag.set_flip_h(true)
		direction = Vector2.LEFT
	else:
		Icon.set_flip_h(false)
		Diag.set_flip_h(false)
		direction = Vector2.RIGHT

var move_dir = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move_dir = Vector2.ZERO
	Icon.rotation_degrees = 0
	Icon.visible = true
	Icon.frame = main_offset
	Diag.visible = false
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var up = Input.is_action_pressed("move_up")
	var down = Input.is_action_pressed("move_down")

	if up:
		move_dir.y += -1
		if direction == Vector2.LEFT:
			Icon.rotation_degrees = 90
		else:
			Icon.rotation_degrees = -90
	elif down:
		move_dir.y += 1
		if direction == Vector2.RIGHT:
			Icon.rotation_degrees = 90
		else:
			Icon.rotation_degrees = -90
	if right:
		move_dir.x += 1
		if up:
			Icon.visible = false
			Diag.frame = 1 + diag_offset
			Diag.visible = true
		if down:
			Icon.visible = false
			Diag.frame = 0 + diag_offset
			Diag.visible = true
		last_dir = "Right"
	if left:
		move_dir.x += -1
		if up:
			Icon.visible = false
			Diag.frame = 1 + diag_offset
			Diag.visible = true
		if down:
			Icon.visible = false
			Diag.frame = 0 + diag_offset
			Diag.visible = true
		last_dir = "Left"
	if move_dir == Vector2.ZERO:
		if last_dir == "Left":
			move_dir = Vector2.LEFT
		else:
			move_dir = Vector2.RIGHT
	
	move_dir = move_dir.normalized() * bullet_speed
	
	if Input.is_action_just_pressed("shoot") && move_dir != Vector2.ZERO:
		if(rng.randi_range(0,100) < marbling * 15):
			var mar_ins = marble.instance()
			get_parent().owner.add_child(mar_ins)
			mar_ins.set_vars(global_position.x, global_position.y, move_dir, damage, youtube)
			pew.play()
		else:
			var bull_ins = bullet.instance()
			get_parent().owner.add_child(bull_ins)
			bull_ins.set_vars(global_position.x, global_position.y, move_dir, damage, youtube)
			pew.play()
		
		
	elif Input.is_action_just_pressed("shoot"):
		if(rng.randi_range(0,100) < marbling * 15):
			var mar_ins = marble.instance()
			get_parent().owner.add_child(mar_ins)
			mar_ins.set_vars(global_position.x, global_position.y, move_dir, damage, youtube)
			pew.play()
		else:
			var bull_ins = bullet.instance()
			get_parent().owner.add_child(bull_ins)
			bull_ins.set_vars(global_position.x, global_position.y, move_dir, damage, youtube)
			pew.play()
		
func shoot_hold():
	rng.randomize()
	if(rng.randi_range(0,100) < marbling * 15):
		var mar_ins = marble.instance()
		get_parent().owner.add_child(mar_ins)
		mar_ins.set_vars(global_position.x, global_position.y, move_dir, damage, youtube)
		pew.play()
	else:
		var bull_ins = bullet.instance()
		get_parent().owner.add_child(bull_ins)
		bull_ins.set_vars(global_position.x, global_position.y, move_dir, damage, youtube)
		pew.play()
