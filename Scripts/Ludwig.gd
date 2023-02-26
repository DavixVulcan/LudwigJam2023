extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var splash = preload("res://Scenes/SplashDamage.tscn")
var my_bull = preload("res://Scenes/EnemBullet.tscn")
onready var bar = $"../ProgressBar2"
onready var anims = $"../AnimationPlayer"
onready var attack = $"../Attack"
onready var music = $"../Music"
onready var area_box = $Lud
var health = 1000
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()
	anims.play("Introduction")
	pass # Replace with function body.

func bar_vis():
	bar.visible = true
	

var angle = 0

func spawn_splash():
	var splash_inst = splash.instance()
	get_parent().get_parent().call_deferred("add_child", splash_inst)
	var count = 5
	var radius = 50.0
	var center = area_box.global_position
	
	var direction = Vector2(cos(angle), sin(angle))
	var pos = center + direction * radius
	
	splash_inst.set_global_position(pos)
	print(splash_inst.global_position)
	
	angle += rng.randi_range(0,60)
	
	
func attack_sound():
	attack.play()

func damage(dam):
#	print("Damaeged")
	health -= dam
	bar.value = health
	if health <= 0:
		anims.stop()
		anims.clear_queue()
		anims.play("Defeated")
		area_box.disabled = true
		attack.stop()
		$"../Label".visible = true
		pass

func queue_rand_anim():
	
	rng.randomize()
	var item = rng.randi_range(1,4)
	match item:
		1:
			anims.queue("Bishop")
			pass
		2:
			anims.queue("IdlyRunBullets")
			pass
		3: 
			anims.queue("Rook")
			pass
		4:
			anims.queue("Pawn")
	

func shoot():
	var bull_inst = my_bull.instance()
	get_parent().get_parent().call_deferred("add_child", bull_inst)
	bull_inst.set_vars(area_box.global_position, Vector2.DOWN * 2, 7)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
