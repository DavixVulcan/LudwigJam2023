extends KinematicBody2D

onready var sprite = $MogulMoney
onready var bing = $AudioStreamPlayer

#var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var gravity = 1000
var killed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.UP * 100
#	print("created")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_Area2D_body_entered(body):
	if body.name == "Coots" and !killed:
		sprite.visible = false
		killed = true
		body.add_coins(5)
		bing.play()
		
		yield(bing, "finished")
		queue_free()
