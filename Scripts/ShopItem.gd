extends Node2D


onready var Costy = $Label
onready var Labely2 = $Label/Label2
onready var anim = $AnimationPlayer
onready var Items = $Items

export var item = 8
var views = 0
export var cost = 0
var interactably = false
var used = false
var bodys

# Called when the node enters the scene tree for the first time.
func _ready():
#	get_parent().get_node("Coots").connect("view_count", self, "_on_view_count")
	Items.frame = item
	anim.play("Idle")
	match item:
		9:
			Labely2.text = "Money+"
		10:
			Labely2.text = "Base Stats+"
		11:
			Labely2.text = "Splash Damage"
		12:
			Labely2.text = "Damage++"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("interact") && interactably && !used:
		if bodys.viewership >= cost:
#			Anim.play("Interact")
			match item:
				9:
					bodys.upgrade_mogul()
				10:
					bodys.upgrade_moist()
				11:
					bodys.upgrade_youtube()
				12:
					bodys.upgrade_inner()
			used = true
			Costy.visible = false
			Items.visible = false

func _on_view_count(viewslol):
	views = viewslol


func _on_Area2D_body_entered(body):
	if body.name == "Coots" and !used:
		bodys = body
		Costy.visible = true
		Costy.text = ("Viewers Needed(" + str(cost * 10) + ")")
		interactably = true


func _on_Area2D_body_exited(body):
	if body.name == "Coots":
		Costy.visible = false
		interactably = false
