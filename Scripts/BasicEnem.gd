extends KinematicBody2D

onready var nav = $NavigationAgent2D
onready var anim = $AnimationPlayer
onready var deab = $Death
onready var coll1 = $CollisionShape2D
onready var coll2 = $Area2D/CollisionShape2Dd
onready var shooting = $Shooting

var speed = 20
var velocity = Vector2.ZERO
var target = Vector2.ZERO
var coin = preload("res://Scenes/Coin.tscn")
var my_bull = preload("res://Scenes/EnemBullet.tscn")
var health = 2
var killed = false
var idle = false
var damager = 3

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func shoot():
#	print("haha")
	
	if idle:
		var bull_inst = my_bull.instance()
		get_parent().call_deferred("add_child", bull_inst)
		bull_inst.set_vars(global_position, global_position.direction_to(target + Vector2(0,-8)), damager)
		pass

func _ready():
	get_parent().get_node("Coots").connect("global_pos", self, "_on_global_pos")
	rng.randomize()
	anim.play("Idle")
	anim.seek(rng.randf_range(0,3))
	
	shooting.play("Shooting")
	pass # Replace with function body.

func arrived():
	return position.distance_to(target) < 100
	pass

func _on_global_pos(positions):
	nav.set_target_location(positions)
	target = positions
	pass

func _process(_delta):
	
	var move_direction = global_position.direction_to(nav.get_next_location())
	velocity = move_direction * speed
	nav.set_velocity(velocity)
	
	if not arrived():
		velocity = move_and_slide(velocity)
		idle = false
#		velocity = Vector2.UP * speed
#		velocity = move_and_slide(velocity)
	else:
		idle = true

func damage(dam):
	health -= dam
	if health <= 0 and !killed:
			killed = true
			visible = false
			get_parent().find_node("Coots").add_view()
			coll1.call_deferred("set_disabled", true)
			coll2.call_deferred("set_disabled", true)
#			coll2.disabled = true
			var coin_inst = coin.instance()
			get_parent().call_deferred("add_child", coin_inst)
			coin_inst.global_position = global_position + Vector2(0, 0)
			deab.play()
			yield(deab, "finished")
			queue_free()

func _on_Area2D_body_entered(_body):
#	print("Bodied")
#	if body.name == "Bullet":
##		print("bullet")
#		health -= body.damage
#		body.delat()
#		if health <= 0 and !killed:
#			killed = true
#			visible = false
#			coll1.call_deferred("set_disabled", true)
#			coll2.call_deferred("set_disabled", true)
##			coll2.disabled = true
#			var coin_inst = coin.instance()
#			get_parent().call_deferred("add_child", coin_inst)
#			coin_inst.global_position = global_position + Vector2(0, 0)
#			deab.play()
#			yield(deab, "finished")
#			queue_free()
#	if body.name == "Marble":
##		print("Marble")
#		health -= body.damage
#		body.delat()
#		if health <= 0 and !killed:
#			killed = true
#			visible = false
#			coll1.call_deferred("set_disabled", true)
#			coll2.call_deferred("set_disabled", true)
##			coll2.disabled = true
#			var coin_inst = coin.instance()
#			get_parent().call_deferred("add_child", coin_inst)
#			coin_inst.global_position = global_position + Vector2(0, 0)
#			deab.play()
#			yield(deab, "finished")
#			queue_free()
	pass
	
#	elif body.name == "SplashDamage"


func _on_Area2D_area_entered(_area):
#	if area.name == "SplashDamage":
#		print("Splash")
#		health -= area.damage
#		if health <= 0 and !killed:
#			print("killed by splash")
#			killed = true
#			visible = false
#			coll1.call_deferred("set_disabled", true)
#			coll2.call_deferred("set_disabled", true)
##			coll2.disabled = true
#			var coin_inst = coin.instance()
#			get_parent().call_deferred("add_child", coin_inst)
#			coin_inst.global_position = global_position + Vector2(0, 0)
#			deab.play()
#			yield(deab, "finished")
#			queue_free()
	pass # Replace with function body.
