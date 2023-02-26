extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var collision_info
var damage = 1
var splash = false
var item = preload("res://Scenes/SplashDamage.tscn")

func set_vars(x, y, dir, dam, yout):
	velocity = dir
	damage = dam
	position.x = x
	position.y = y
	splash = yout
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func delat():
	if splash:
		var item_inst = item.instance()
		get_parent().call_deferred("add_child", item_inst)
		item_inst.initialize(damage)
		item_inst.position = global_position
		pass
	queue_free()
	pass

func _process(_delta):
	if velocity == Vector2.ZERO:
		delat()
	collision_info = move_and_collide(velocity)
	if collision_info != null:
#		print(collision_info.collider.name)
		if str(collision_info.collider.get_class()) == "TileMap":
			delat()
		if "BasicEnem" in collision_info.collider.name or "Ludwig" in collision_info.collider.name:
			collision_info.collider.damage(damage)
			delat()
#		else:
#			pass
