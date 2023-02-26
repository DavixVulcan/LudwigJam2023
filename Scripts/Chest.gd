extends Node2D

onready var Labely = $Node2D/Label
onready var Labely2 = $Node2D/Label/Label2
onready var Anim = $AnimationPlayer
onready var Aud = $AudioStreamPlayer
var cost = 0 
var item = preload("res://Scenes/Item.tscn")
var interactably = false
var used = false
var user_bank = 0
var bodys

# Called when the node enters the scene tree for the first time.
func _ready():
	Anim.play("Idle")

func _physics_process(_delta):
	if Input.is_action_pressed("interact") && interactably && !used:
		if bodys.coins >= cost:
			var item_inst = item.instance()
			Anim.play("Interact")
			get_parent().add_child(item_inst)
			item_inst.global_position = global_position + Vector2(0, -30)
			Aud.play()
			used = true
			bodys.delete_coins(cost)

func _on_Area2D_body_entered(body):
	if body.name == "Coots":
		bodys = body
		Labely.visible = true
		cost = body.stage_cost
		Labely2.text = ("Cost(" + str(cost) + ")")
		interactably = true

func _on_Area2D_body_exited(body):
#	print(str('Body exited: ', body.get_name()))
	if body.name == "Coots":
		Labely.visible = false
		interactably = false
