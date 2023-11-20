extends "res://src/Card.gd"

onready var icon = $Sprite
onready var label = $Label
onready var hearts = $Hearts

var player_name = "";
var hp = 5;

func _ready():
	randomize();
	var _i = randi()%4
	icon.texture = load("res://assets/character_icons/%s.jpg"%[_i])
	label.text = player_name
	
	for _bt in [$AddHp,$RemoveHp]:
		_bt.connect("pressed",self,"on_button_pressed",[_bt.name])
	update_hearts();
	
func on_button_pressed(_id):
	match _id:
		"AddHp":
			hp = min(hp+1,5)
			update_hearts()
		"RemoveHp":
			hp = max(hp-1,0)
			update_hearts()
		
func update_hearts():
	for _i in 5:
		var _heart = hearts.get_child(_i)
		_heart.visible = hp > _i
		
