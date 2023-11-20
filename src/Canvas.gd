extends CanvasLayer

onready var input_player_name = $Panel/InputPlayerName
onready var player_list = $PlayerScroll/PlayerList
onready var create_player_button = $Panel/CreatePlayer
onready var create_character_button = $Panel/CreateCharacter
onready var create_card_button = $Panel/CreateCard
onready var create_class_button = $Panel/CreateClass
onready var create_5_cards = $Panel/Create5Cards

onready var remove_all_button = $Panel/RemoveAll


onready var world = get_parent();
onready var tw = get_tree().current_scene.get_node("Tween");

func _ready():
	create_player_button.connect("button_down",self,"create_player")
	create_character_button.connect("button_down",self,"create_character")
	create_card_button.connect("button_down",self,"create_card")
	create_class_button.connect("button_down",self,"create_class_card")
	create_5_cards.connect("button_down",self,"create_5cards")
	remove_all_button.connect("button_down",self,"remove_all_cards")
	
func _process(dt):
	if Input.is_action_just_pressed("tab"):
		visible = !visible;

func create_player():
	if len(input_player_name.text) > 0:
		var _card = preload("res://src/PlayerCard.tscn").instance();
		Global.add_player(input_player_name.text);
		_card.player_name = input_player_name.text;
		world.cards.add_child(_card);
	
		tw.interpolate_property(_card,"scale",Vector2.ONE*1.1,Vector2.ONE,0.2,Tween.TRANS_CUBIC,Tween.EASE_OUT)
		tw.start();
	
func create_character():
	var _i = randi()%len(world.characters);
	var _char = world.characters[_i]
	world.characters.remove(_i);
	
	var _card = preload("res://src/Card.tscn").instance();
	_card.texture = load("res://assets/cards/characters/%s.png"%[_char])
	world.cards.add_child(_card);
	
	tw.interpolate_property(_card,"scale",Vector2.ONE*1.1,Vector2.ONE,0.2,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tw.start();

func create_5cards():
	for _i in 5:
		create_card(_i*250);
	
func create_card(offset_x=0):
	var _i = randi()%len(world.items);
	var _item = world.items[_i]
	
	var _card = preload("res://src/Card.tscn").instance();
	_card.texture = load("res://assets/cards/items/%s.png"%[_item])
	world.cards.add_child(_card);
	_card.position.x = offset_x;
	
	tw.interpolate_property(_card,"scale",Vector2.ONE*1.1,Vector2.ONE,0.2,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tw.start();

func create_class_card():
	var _class = "outlaw"
	if !world.classes.empty():
		var _i = randi()%len(world.classes);
		_class = world.classes[_i]
		world.classes.remove(_i);
	
	var _card = preload("res://src/Card.tscn").instance();
	_card.texture = load("res://assets/cards/classes/%s.png"%[_class])
	world.cards.add_child(_card);
	
	tw.interpolate_property(_card,"scale",Vector2.ONE*1.1,Vector2.ONE,0.2,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tw.start();

func remove_all_cards():
	for _i in world.cards.get_children():
		_i.queue_free();
