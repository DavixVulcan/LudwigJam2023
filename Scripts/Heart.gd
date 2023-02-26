extends Node2D

onready var Tweeny = $Tween
onready var Hearts = $NewHearts

func fill_all_zero():
	Tweeny.interpolate_property(Hearts, "frame", 0, 4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	Tweeny.start()
	
func fill_to(num_to):
	if num_to != Hearts.frame:
		Tweeny.interpolate_property(Hearts, "frame", Hearts.frame, num_to, .25 * abs(Hearts.frame - num_to),
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		Tweeny.start()

func _ready():
	pass # Replace with function body.

