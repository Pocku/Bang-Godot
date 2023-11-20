extends Control

onready var label = $Label
onready var sprite = $Sprite
onready var remove_button = $Remove

var id = 0;

func _ready():
	remove_button.connect("button_down",self,"on_remove_pressed")
	randomize()
	var _icon = str(randi()%4);
	sprite.texture = load("res://assets/character_icons/%s.jpg"%[_icon])
	label.text = id.capitalize();
	
func on_remove_pressed():
	Global.remove_player(id);
	queue_free()
