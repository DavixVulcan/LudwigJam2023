extends Label

onready var stage = $StageNum
onready var stage2 = $StageNum2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_stage(sta = 0): 
	if sta == 0:
		stage.add_color_override("font_color",  Color.crimson)
		stage.text = "FIGHT"
		stage.visible = false
		stage2.visible = true
	else:
		stage.text = str(sta)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
