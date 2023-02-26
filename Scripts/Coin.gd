extends KinematicBody2D

onready var bing  = $AudioStreamPlayer
onready var coll1 = $CollisionShape2D
onready var coll2 = $Area2D/CollisionShape2dD
onready var sprite = $Area2D/Coin
var item = preload("res://Scenes/MogulMoney.tscn")
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
var gravity = 1000
var killed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.UP * 100
	rng.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Coots" and !killed:
		if (rng.randi_range(0,5) == 5) and body.mogul_money:
			var item_inst = item.instance()
			get_parent().call_deferred("add_child", item_inst)
			item_inst.global_position = global_position + Vector2(0, -30)
#		owner.add_child(item_inst)
			
		sprite.visible = false
		killed = true
		body.add_coins()
		bing.play()
		
		yield(bing, "finished")
		queue_free()
