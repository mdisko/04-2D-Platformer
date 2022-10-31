extends Node2D

onready var Bat = load("res://Enemy/Bat.tscn")
onready var Bug = load("res://Enemy/Bug.tscn")

func _physics_process(_delta):
	if not has_node("Bat"):
		var bat = Bat.instance()
		add_child(bat)
		bat.name = 'Bat'
	if not has_node("Bug"):
		var bug = Bug.instance()
		add_child(bug)
		bug.name = 'Bug'
