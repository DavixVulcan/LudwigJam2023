extends Node2D
onready var Heart = $Heart
onready var Heart1 = $Heart1
onready var Heart2 = $Heart2
onready var Heart3 = $Heart3
onready var Heart4 = $Heart4
onready var Heart5 = $Heart5
onready var Heart6 = $Heart6
onready var Heart7 = $Heart7
onready var Heart8 = $Heart8
onready var Heart9 = $Heart9
onready var Heart10 = $Heart10
onready var Heart11 = $Heart11
onready var Heart12 = $Heart12
onready var Heart13 = $Heart13
onready var Tweeny = $Tween
onready var lab = $Node2D2/Label
#onready var UIAnim = $"../UIAnim"

onready var Hearts_arr = [Heart, Heart1, Heart2, Heart3, Heart4, Heart5, Heart6, 
				  Heart7, Heart8, Heart9, Heart10, Heart11, Heart12, Heart13]

var health = 4
var maxHearts = 4
var maxHealth =  16
var currentHeart = 0
var pastHealth = 0

func enable_hearts(hearted):
	maxHearts = hearted
	maxHealth = maxHearts * 4
	var y = maxHearts
	
	for x in Hearts_arr:
		if y != 0:
			x.visible = true
			y = y - 1
	if maxHearts > 7:
		lab.rect_position.y += 24
	else:
		lab.rect_position.y += 0 

func update_health(hea, maxHeart, maxHealt):
	pastHealth = health
	health = hea
	maxHearts = maxHeart
	maxHealth = maxHealt
	
	enable_hearts(maxHearts)
	lab.text = str(health)
	set_hearts(hea)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func anim_hearts(hea):
	
#	var togo = hea
#	while togo > 0:
#		togo = togo - (4 - currentHeart.Hearts.frame)
#		pass
	
#	set_hearts(hea)
	
	for x in range(maxHearts):


		if(hea >= ((x + 1) * 4)):
			if x == 0:
				Tweeny.interpolate_property(Hearts_arr[x].Hearts, "frame", Hearts_arr[x].Hearts.frame, 4, 1)

			else:
				Tweeny.interpolate_callback(Hearts_arr[x], (x - currentHeart) if ((x - currentHeart) > 0) else 0, "fill_to", 4)
#				print("reach elsy")
		elif hea > 0 && hea < 4 && x == 0:
			Tweeny.interpolate_property(Hearts_arr[x].Hearts, "frame", Hearts_arr[x].Hearts.frame, hea, 1)
		else:
			if (hea > x * 4):
				Tweeny.interpolate_callback(Hearts_arr[x], (x - currentHeart) if ((x - currentHeart) > 0) else 0, "fill_to", (hea - x * 4))
	Tweeny.interpolate_callback(self, (hea - pastHealth) * .25, "set_hearts", hea)
	Tweeny.start()
	currentHeart = hea/4
	
		
#func damage_anim():
#	UIAnim.play("Damage")
func set_blank():
	Tweeny.remove_all()
	for x in range(maxHearts):
		Hearts_arr[x].Hearts.frame = 0

func set_hearts(hea):
	Tweeny.remove_all()
	set_blank()
	for x in range(maxHearts):
		if(hea > ((x + 1) * 4)):
			Hearts_arr[x].Hearts.frame = 4
		else:
			if (hea >= x * 4):
				Hearts_arr[x].Hearts.frame = (hea - x * 4)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
