extends Node2D

onready var Anim = $AnimationPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bodys

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	
	if body.name == "Coots":
		bodys = body
		Anim.play("Harm")
	pass # Replace with function body.

func harm():
	if bodys.name == "Coots":
		bodys.damage(4)


func _on_Area2D_body_exited(body):
	
	if body.name == "Coots":
		Anim.stop()
	pass # Replace with function body.
