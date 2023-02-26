extends KinematicBody2D

export var move_speed := 100
export var gravity := 2000
export var jump_speed := 550
var health = 16
var maxHearts = 4
var maxHealth =  16
var armor = 1
var dam = 1
var splash = false
var moist = 0
var boon = 1
var baked = 0
var mogul_money = false
var yippee = false

signal global_pos(position)

onready var Jumpin = $Jumpin
onready var Dialogue = $Camera2D/DialogueBox
onready var anim = $AnimationPlayer
onready var Healing = $Health
onready var Tweeny = $Tween
onready var UIAnim = $UIAnim
onready var Idle = $Idle
onready var Jump = $Jump
onready var Run = $Run
onready var Gun = $Gun
onready var Hurt = $CootsHurt
onready var HeartBox = $Camera2D/Heart
onready var CoinBox = $Camera2D/Viewers/Coin
onready var TimeLab = $Camera2D/TimeRect/TimeLab
onready var TimeRect = $Camera2D/TimeRect
onready var sprites = [Idle, Jump, Run, Hurt]

onready var Item = $Camera2D/ColorRect2/Items
onready var Item2 = $Camera2D/ColorRect2/Items2
onready var Item3 = $Camera2D/ColorRect2/Items3
onready var Item4 = $Camera2D/ColorRect2/Items4
onready var Item5 = $Camera2D/ColorRect2/Items5
onready var Item6 = $Camera2D/ColorRect2/Items6
onready var Item7 = $Camera2D/ColorRect2/Items7
onready var Item8 = $Camera2D/ColorRect2/Items8
onready var Item9 = $Camera2D/ColorRect2/Items9
onready var Item10 = $Camera2D/ColorRect2/Items10
onready var Item11 = $Camera2D/ColorRect2/Items11
onready var Item12 = $Camera2D/ColorRect2/Items12

onready var ItLab = $Camera2D/ColorRect2/Label
onready var ItLab2 = $Camera2D/ColorRect2/Label2
onready var ItLab3 = $Camera2D/ColorRect2/Label3
onready var ItLab4 = $Camera2D/ColorRect2/Label4
onready var ItLab5 = $Camera2D/ColorRect2/Label5
onready var ItLab6 = $Camera2D/ColorRect2/Label6
onready var ItLab7 = $Camera2D/ColorRect2/Label7
onready var ItLab8 = $Camera2D/ColorRect2/Label8
onready var ItLab9 = $Camera2D/ColorRect2/Label9
onready var ItLab10 = $Camera2D/ColorRect2/Label10
onready var ItLab11 = $Camera2D/ColorRect2/Label11
onready var ItLab12 = $Camera2D/ColorRect2/Label12

var enemy = preload("res://Scenes/BasicEnem.tscn")

onready var View = $Camera2D/Viewers/Viewcount
onready var Hurtin = $Hurtin
onready var StageLabel = $Camera2D/Stage
onready var Yippeee = $Yippee
onready var Yipanim = $Yippees
onready var Cam = $Camera2D
onready var Normal = $Normal

onready var item_sprites = [Item, Item2, Item3, Item4, Item5, Item6, Item7, Item8, Item9, Item10, Item11, Item12]
onready var item_labs = [ItLab, ItLab2, ItLab3, ItLab4, ItLab5, ItLab6, ItLab7, ItLab8, ItLab9, ItLab10, ItLab11, ItLab12]
onready var item_labs_vals = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

func add_item(itz):
	var found = false
	var found_new = false
	for x in range(len(item_sprites)):
		if item_sprites[x].frame == itz:
			item_labs_vals[x] += 1
			item_labs[x].text = str(item_labs_vals[x])
			found = true
	if !found:
		for x in range(len(item_sprites)):
			if found_new:
				break
			if item_sprites[x].frame == 0:
				item_sprites[x].frame = itz
				item_labs_vals[x] += 1
				item_labs[x].text = str(item_labs_vals[x])
				found_new = true


var velocity := Vector2.ZERO
var hurt = false
onready var timer = $Timer

var viewership = 0
var coins = 0 
var stage = 1
var stage_cost = 2

export var start_minutes = 7
var minutes
export var seconds = 0
var dsec = 0
var tim_text
var spawner_enabled = true

# Get how much of an angle objects will be spaced around the circle.
# Angles are in radians so 2.0*PI = 360 degrees
var spawned = false

var angle = 0
# For each node to spawn

func spawner(spawn = 5):
	var count = spawn
	var radius = 200.0
	var center = global_position
	var angle_step = 2.0*PI / count
	
	if spawner_enabled:
		for _i in range(0, count):
			
			var direction = Vector2(cos(angle), sin(angle))
			var pos = center + direction * radius
			
			var node = enemy.instance()
			node.set_position(pos)
			get_parent().add_child(node)
			angle += angle_step

func add_view():
	viewership += 1
	View.text = str(viewership * 10)

func add_coins(con = 0):
	coins += boon
	coins += con
	CoinBox.text = str(coins)
	
func delete_coins(coinsy):
	coins -= coinsy
	CoinBox.text = str(coins)

#makes only this sprite visible
func only_vis(name):
	for x in sprites:
		if x.get_name() == name:
			x.visible = true
		else:
			x.visible = false

func heal_amount(he):
	health += he
	if health >= maxHealth:
		health = maxHealth
	HeartBox.update_health(health, maxHearts, maxHealth)
	if he > 0:
		HeartBox.anim_hearts(health)

onready var Gameover = preload("res://Scenes/GameOver.tscn")

func damage(da):
	if !yippee:
#		print(da)
		HeartBox.Tweeny.stop_all()
		UIAnim.play("Damage")
		Healing.stop()
		Tweeny.remove_all()
		hurt = true
		only_vis("Hurt")
		anim.play("Hurt")
		Tweeny.interpolate_callback(self, 3, "start_healing")
		Tweeny.interpolate_callback(self, .25, "stop_damage")
#		Tweeny.interpolate_property(self, self.hurt, true, false, 1)
		Tweeny.start()
		Hurtin.play()
		if(da - armor) > 0:
			health -= (da - armor)
			HeartBox.update_health(health, maxHearts, maxHealth)
			HeartBox.set_hearts(health)
			
		if health <= 0:
			health = 0
			HeartBox.update_health(health, maxHearts, maxHealth)
			HeartBox.set_hearts(health)
			StageLabel.set_stage()
			var node = Gameover.instance()
			node.set_position(Vector2(432, 1110))
			get_parent().call_deferred("add_child", node)
			Cam.set_as_toplevel(true)
			Cam.position = Vector2(672, 1290)
			global_position = Vector2(672, 1400)

# Called when the node enters the scene tree for the first time.
func _ready():
#	upgrade_yippee()
	HeartBox.update_health(health, maxHearts, maxHealth)
	HeartBox.anim_hearts(health)
	start_healing()
	Normal.play()
#	upgrade_damage(300)
#	damage(18)
	minutes = start_minutes
	pass # Replace with function body.

func upgrade_yippee():
	yippee = true
	Yippeee.visible = true
	Dialogue.item_izer(8)
	Jumpin = $Jumpin/Yippees
	Yipanim.play("Yip")
#	add_item(8)

func finish_yippee():
	yippee = false
	Yippeee.visible = false
	Jumpin = $Jumpin

func upgrade_mogul():
	mogul_money = true
	Dialogue.item_izer(9)
	add_item(9)

func upgrade_moist():
	dam += 1
	Gun.damage = dam
	armor += 2
	move_speed += 5
	Dialogue.item_izer(10)
	add_item(10)

func upgrade_youtube():
	Gun.upgrade_to_youtube()
	Dialogue.item_izer(11)
	add_item(11)

func upgrade_inner():
	Gun.upgrade_inner()
	Dialogue.item_izer(12)
	add_item(12)

func upgrade_hearts(addheart = 1):
	maxHearts += addheart
	if !(maxHearts > 14):
		maxHealth = maxHearts * 4
		health = maxHealth
		HeartBox.update_health(maxHealth, maxHearts, maxHealth)
		add_item(2)
		Dialogue.item_izer(2)
	else:
		maxHearts = 14

func upgrade_heals(heals = 1):
	baked += heals
	Healing.play("Heal", -1, 1 + (baked * .2))
	add_item(7)
	Dialogue.item_izer(7)

func upgrade_damage(damy = 1):
	dam += damy
	Gun.damage = dam
	add_item(4)
	Dialogue.item_izer(4)

func upgrade_speed(speedy = 1):
	move_speed += speedy * 15
	add_item(1)
	Dialogue.item_izer(1)

func upgrade_def(defe = 1):
	armor += defe
	add_item(3)
	Dialogue.item_izer(3)

func upgrade_boon(boo = 1):
	boon += boo
	add_item(6)
	Dialogue.item_izer(6)

func upgrade_marby(marby = 1):
	Gun.marbling += marby
	add_item(5)
	Dialogue.item_izer(5)

func start_healing():
	Healing.play("Heal", -1, 1 + (baked * .2))
	pass

func stop_damage():
	hurt = false

func _physics_process(delta: float) -> void:
	# reset horizontal velocity
	velocity.x = 0
	tim_text = ""
	if seconds > 0 and dsec <= 0:
		seconds -= 1
		dsec = 10
	if minutes > 0 and seconds <= 0:
		minutes -= 1
		seconds = 60
		
		
	if minutes >= 10:
		tim_text = (str(tim_text) + str(minutes))
	else:
		tim_text = (str(tim_text) + "0" + str(minutes))
	
	stage = start_minutes - minutes
	stage_cost = stage * 2
	
	StageLabel.set_stage(stage)
	
	tim_text += str(":")
	
	if seconds >= 10:
		tim_text = (str(tim_text) + str(seconds))
	else:
		tim_text = (str(tim_text) + "0" + str(seconds))
	TimeLab.text = tim_text
	
	if seconds == 60:
		tim_text = tim_text.left(tim_text.length() - 2)
		tim_text = (str(tim_text) + "00")
		TimeLab.text = tim_text
	
	emit_signal("global_pos", global_position)
	
	# set horizontal velocity
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
		Run.set_flip_h(false)
		Jump.set_flip_h(false)
		Idle.set_flip_h(false)
		Hurt.set_flip_h(false)
		Gun.set_flips(false)
		Yippeee.set_flip_h(false)
		Yippeee.scale.x = 1
		
		if is_on_floor() && !hurt:
			only_vis("Run")
			anim.play("Run")
		
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed
		Run.set_flip_h(true)
		Jump.set_flip_h(true)
		Idle.set_flip_h(true)
		Hurt.set_flip_h(true)
		Gun.set_flips(true)
		Yippeee.set_flip_h(true)
		Yippeee.scale.x = -1
		
		if is_on_floor() && !hurt:
			only_vis("Run")
			anim.play("Run")
		
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_speed
			only_vis("Jump")
			anim.play("Jump")
			Jumpin.play()
			
	if velocity == Vector2.ZERO && !hurt:
		if is_on_floor():
			only_vis("Idle")
			anim.play("Idle")
	
	if velocity.y > 0 && !hurt:
		
		only_vis("Jump")
		Jump.frame = 3
	
	# gravity
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed("shoot"):
		shoot_anim.play("Shoot")
		
	if Input.is_action_just_released("shoot"):
		shoot_anim.stop()
		

onready var shoot_anim = $Shoot
var boss = preload("res://Scenes/BOSSFIGHT.tscn")
var done = false

func _on_Timer_timeout():
	dsec -= 1
	if seconds == 30:
		if !spawned:
			spawner()
			spawned = true
	
	if seconds == 60:
		if !spawned:
			spawner(4)
			spawned = true
	
	if seconds == 29 or seconds == 59:
		spawned = false
		
	if minutes == 0 and seconds == 0:
#		print("finale")
		StageLabel.set_stage()
		StageLabel.visible = false
		TimeRect.visible = false
		Cam.set_as_toplevel(true)
		if !done:
			Cam.position = Vector2(672, 1290)
			global_position = Vector2(672, 1400)
			done = true
			var bossy = boss.instance()
			owner.call_deferred("add_child", bossy)
			bossy.position = Vector2(432, 1120)
			Normal.stop()
		pass
