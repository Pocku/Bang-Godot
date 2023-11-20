extends Node2D

onready var characters = get_files_in_dir("res://assets/cards/characters/")
onready var items = get_files_in_dir("res://assets/cards/items/")
onready var classes = get_files_in_dir("res://assets/cards/classes/")
onready var cards = $Cards
onready var cam = $Camera

var card = null;

func _ready():

	var _items = [
		'bang',
		'barrel',
		'beer',
		'carabine',
		'catling',
		'cat_balou',
		'duel',
		'dynamite',
		'emporio',
		'indians',
		'jail',
		'miring',
		'missed',
		'mustang',
		'panic',
		'saldon',
		'schofield',
		'stagecoach',
		'volcanic',
		'wells_fargo',
		'winchester'
	]

	var _classes = [
		'outlaw',
		'renegade',
		'sheriff',
		'vice'
	]
	var _chars = [
		'bart_cassidy',
		'black_jack',
		'calamity_janet',
		'el_gringo',
		'jesse_jones',
		'jourdonnais',
		'kit',
		'lucky',
		'paul',
		'pedro',
		'rose',
		'sid',
		'slab',
		'suzy',
		'vulture',
		'willy'
	]

	characters = _chars
	classes = _classes
	items = _items

func _input(ev):
	if ev is InputEventMouseButton:
		if ev.button_index == BUTTON_WHEEL_DOWN:
			cam.zoom += Vector2.ONE*0.1;
		if ev.button_index == BUTTON_WHEEL_UP:
			cam.zoom -= Vector2.ONE*0.1;
		for _i in ["x","y"]:
			cam.zoom[_i]=clamp(cam.zoom[_i],0.1,5)
	
	if ev is InputEventMouseMotion:
		if Input.is_action_pressed("mb_r"):
			cam.offset += -ev.relative*cam.zoom;
	
func _process(dt):
	if Input.is_action_just_pressed("mb_left"):
		var cards_group = get_tree().get_nodes_in_group("card");
		for _i in range(len(cards_group)-1,-1,-1):
			var _new_card = cards_group[_i]
			var _card_rect = {"x":_new_card.global_position.x,"y":_new_card.global_position.y,"w":250*_new_card.scale.x,"h":389*_new_card.scale.y}
			var _can_grab = _new_card.point_in_rect(get_global_mouse_position(), _card_rect)
			if _can_grab:
				cards.move_child(_new_card,cards.get_child_count()-1)
				card = _new_card;
				card.grab_mouse = get_global_mouse_position() - card.global_position;
				card.moving = true;
				break;
	
	if card != null:
		card.global_position += (get_global_mouse_position() - card.global_position) - card.grab_mouse
		
	if Input.is_action_just_released("mb_left") && card != null:
		card.moving = false;
		card = null;
	
	if Input.is_action_pressed("shift"):
		var cards_group = get_tree().get_nodes_in_group("card");
		for _i in len(cards_group):
			var _new_card = cards_group[_i]
			var _card_rect = {"x":_new_card.global_position.x,"y":_new_card.global_position.y,"w":250*_new_card.scale.x,"h":389*_new_card.scale.y}
			var _can_grab = _new_card.point_in_rect(get_global_mouse_position(), _card_rect) 
			_new_card.modulate = Color.white;
			if _can_grab:
				_new_card.modulate = Color.darkgoldenrod;
				if Input.is_action_just_pressed("mb_left"):
					_new_card.queue_free();
					if _new_card == card:
						card = null;
					break;
			else:
				_new_card.modulate = Color.white;
			

func get_files_in_dir(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	dir.list_dir_end();
	return files
