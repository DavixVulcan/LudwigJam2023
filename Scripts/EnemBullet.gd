extends KinematicBody2D

var velocity = Vector2.ZERO
var collision_info
var damage = 2

func set_vars(vectors, dir, dam):
	velocity = dir
	damage = dam
	position = vectors

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func delat():
	queue_free()
#	print("Deleted")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
#	print("Created")
#	print(position)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(_delta):
	if velocity == Vector2.ZERO:
		delat()
	collision_info = move_and_collide(velocity)
	if collision_info != null:
#		print(collision_info.collider.name)
		if str(collision_info.collider.get_class()) == "TileMap":
			delat()
		if "Coots" in collision_info.collider.name:
			collision_info.collider.damage(damage)
			delat()
