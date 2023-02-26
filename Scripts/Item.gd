extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tems = $Items
var rng = RandomNumberGenerator.new()
var item = 0

var velocity = Vector2.ZERO
var gravity = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.UP * 70
	rng.randomize()
	item = rng.randi_range(1,8)
	tems.frame = item
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Area2D_body_entered(body):
	if body.name == "Coots":
		match item:
			1:
				body.upgrade_speed()
			2:
				body.upgrade_hearts()
			3:
				body.upgrade_def()
			4:
				body.upgrade_damage()
			5:
				body.upgrade_marby()
			6:
				body.upgrade_boon()
			7:
				body.upgrade_heals()
			8:
				body.upgrade_yippee()
		queue_free()
