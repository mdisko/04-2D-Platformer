extends Node

var score = 0
var lives = 5
var max_lives = 5
var level = 0
var health = 100
var max_health = 100

var levels = [
	"res://Levels/Level1.tscn"
	,"res://Levels/Level2.tscn"
	,"res://Levels/Level3.tscn"
	,"res://Levels/Level4.tscn"
]

var saves = [
	"user://game-data_0.json"
	
]

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		var menu = get_node_or_null("/root/UI/Menu")
		if menu != null:
			var p = get_tree().paused
			if p:
				menu.hide()
				get_tree().paused = false
			else:
				menu.show()
				get_tree().paused = true

func increase_score(s):
	score += s

func decrease_health(h):
	health -= h

func decrease_lives(l):
	lives -= l
	health = max_health
	if lives <= 0:
		get_tree().change_scene("res://Levels/Game_Over.tscn")

func get_save_data():
	var data = {
		"score":score
		,"lives":lives
		,"health":health
		,"level":level
		,"player":""
		,"goblin":[]
		,"bat":[]
	}
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		data["player"] = var2str(player.position)
	var enemies = get_node("root/Game/Enemy_Container")
	for e in enemies:
		if e.is_in_group("Goblin"):
			var temp = {"position":var2str(e.position), "max_constraint":e.max_constaint, "min_constraint":e.min_constraint}
			data["goblin"].append(temp)
		if e.is_in_group("Bat"):
			var temp = {"position":var2str(e.position)}
			data["bat"].append(temp)
	return data

func load_save_level(data):
	score = data["score"]
	lives = data["lives"]
	health = data["health"]
	level = data["level"]
	
	get_tree().change_scene(levels[level])
	call_deferred("load_save_data", data)

func load_save_data(data):
	var menu = get_node_or_null("/root/UI/Menu")
	if menu != null:
		menu.show()
	
	if data["player"] != "":
		var player = get_node_or_null("/root/Game/Player_Container/Player")
		if player != null:
			player.name = "Player2"
			player.queue_free()
		get_node("/root/Game/Player_Container").spawn(str2var(data["player"]))
	var enemy_container = get_node("/root/Game/Enemy_Container")
	for e in enemy_container.get_children():
		e.queue_free()
	for e in data["goblin"]:
		var attr = {"max_constraint":e["max_constaint"], "min_constraint":e["min_constaint"]}
		enemy_container.spawn("Goblin", attr, str2var(e["position"]))
	for e in data["bug"]:
		var attr = {"max_constraint":e["max_constaint"], "min_constraint":e["min_constaint"]}
		enemy_container.spawn("Bug", attr, str2var(e["position"]))
	for e in data["bat"]:
		var attr = {}
		enemy_container.spawn("Bat", attr, str2var(e["position"]))

func save_game(which_file):
	var file = File.new()
	var data = get_save_data()
	file.open(saves[which_file], File.WRITE)
	file.store_string(to_json(data))
	file.close()

func load_game(which_file):
	var file = File.new()
	if file.file_exists(saves[which_file]):
		file.open(saves[which_file], File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			load_save_data(data)
		else:
			printerr("Corrupted data")
	else:
		printerr("No saved data")
