extends ColorRect

onready var Title = $Title
onready var Content = $Content
onready var Graphic = $Graphic
onready var Blurb = $Blurb
onready var anim = $DiagAnim
onready var get = $GetItem
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func item_izer(item):
	Graphic.frame = item
	anim.stop()
	get.play()
	match item:
		0:
			Title.text = "Otto??"
			Content.text = "You're supposed to be a placeholder!"
			Blurb.text = "You're getting paid by ludwig, right?"
			anim.play("Popup")
		1:
			Title.text = "Racecar Bed"
			Content.text = "Increase speed stat"
			Blurb.text = "The sheets are colored white for no particular reason"
			anim.play("Popup")
		2:
			Title.text = "Swipe+ Bidet"
			Content.text = "Increase health by one heart"
			Blurb.text = "Feeling like a new and refreshed person out of the bathroom"
			anim.play("Popup")
		3:
			Title.text = "Castling"
			Content.text = "Increase armor stat"
			Blurb.text = "My elo can't go that low, can it?"
			anim.play("Popup")
		4:
			Title.text = "Chess boxing"
			Content.text = "Increase damage stat"
			Blurb.text = "The best combination since peanut butter and jelly"
			anim.play("Popup")
		5:
			Title.text = "Marbles"
			Content.text = "Random chance to shoot marble, dealing double damage"
			Blurb.text = "Marbles, where the greatest have fallen"
			anim.play("Popup")
		6:
			Title.text = "Mr. Beast's Charity"
			Content.text = "Gain 1 extra coin on coin pickup"
			Blurb.text = "In this video, I shamelessly stole from a more popular creator!"
			anim.play("Popup")
		7:
			Title.text = "QT's Baked Goods"
			Content.text = "Increase health regen"
			Blurb.text = "The only thing more sweet than the goods are the bakers!"
			anim.play("Popup")
		9:
			Title.text = "Mogul Money"
			Content.text = "When collecting coins, chance of extra payout"
			Blurb.text = "Mogul moves isn't an action, its a lifestyle"
			anim.play("Popup")
			pass
		
		8:
			Title.text = "YIPPEE"
			Content.text = "Temporary Invulnerability"
			Blurb.text = "Fortnite and drink cola!!!"
			anim.play("Popup")
			pass
		10:
			Title.text = "Moist Esports"
			Content.text = "All base stats are upgraded"
			Blurb.text = "Didn't Susan give you a lot of money to burn?"
			anim.play("Popup")
			pass
		11:
			Title.text = "Switch To Youtube"
			Content.text = "Upon impact, bullets cause splash damage"
			Blurb.text = "Twitch? Never heard of her"
			anim.play("Popup")
			pass
		12:
			Title.text = "Contract Signage"
			Content.text = "Massive damage boost"
			Blurb.text = "The relationship may be toxic but boy do they pay"
			anim.play("Popup")
			pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
