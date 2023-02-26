extends Area2D

var damage = 1
onready var anim = $AnimationPlayer
onready var boom = $AudioStreamPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func initialize(dam = 0):
	damage = dam
	
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Boom")
	boom.play()
	pass # Replace with function body.

func delat():
	queue_free()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_SplashDamage_body_entered(body):
	if "BasicEnem" in body.name or "Ludwig" in body.name:
#		print("hit")
		body.damage(damage)
	pass # Replace with function body.
