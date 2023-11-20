extends Node

var players = [];

func add_player(_name):
	var _data = {
		"name": _name,
		"character": "",
		"class": "",
		"hp": 3,
		"weapon": "",
		"armor": "",
		"items": []
	}
	players.append(_data);

func remove_player(_id):
	for _i in len(players):
		if players[_i].name == _id:
			players.remove(_i)
			break;
