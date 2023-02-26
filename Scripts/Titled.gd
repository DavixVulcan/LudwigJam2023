extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game = preload("res://Scenes/MainGame.tscn")
onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.

func _ready():
	anim.play("Idle", .8)
	pass # Replace with function body.

var done = false
var stage = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		
		if !done:
			stage += 1
			match stage:
				1:
					$CootsSplash.visible = false
					$Label4.visible = false
					$Label.visible = true
					$Label2.visible = true
					$Label3.visible = true
				2:
					anim.queue_free()
					$Hills4.queue_free()
					$Hills3.queue_free()
					$Hills2.queue_free()
					$Hills1.queue_free()
					$TileMap.queue_free()
					$CootsIdle.queue_free()
					$CootsSplash.queue_free()
					$Label.queue_free()
					$Label2.queue_free()
					$Label3.queue_free()
					$Label4.queue_free()
					var gamer = game.instance()
					call_deferred("add_child", gamer)
					done = true
				3:
					pass
			
