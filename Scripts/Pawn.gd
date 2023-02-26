extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func resed_damage():
	damaged = false

var damaged = false

func _on_Pawn_body_entered(body):
	if body.name == "Coots" and !damaged:
		body.damage(10)
		damaged = true
