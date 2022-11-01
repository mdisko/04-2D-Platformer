extends Node2D

onready var Bat = load("res://Enemy/Bat.tscn")
onready var Bug = load("res://Enemy/Bug.tscn")
onready var Goblin = load("res://Enemy/Goblin.tscn")

func _ready():
	spawn("Bat", {"max_constraint":1600, "min_constraint":1200}, Vector2(1000,1000))

func _physics_process(_delta):
	if not has_node("Bat"):
		var bat = Bat.instance()
		add_child(bat)
		bat.name = 'Bat'
	if not has_node("Bug"):
		var bug = Bug.instance()
		add_child(bug)
		bug.name = 'Bug'
	if not has_node("Goblin"):
		var goblin = Goblin.instance()
		add_child(goblin)
		goblin.name = 'Goblin'
		
func spawn(e_type, attr, p):
	var enemy = null
	if e_type == "Bat":
		enemy = Bat.instance()
	if e_type == "Bug":
		enemy = Bug.instance()
	if e_type == "Goblin":
		enemy = Goblin.instance()
	enemy.position = p
	add_child(enemy)
