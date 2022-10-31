extends Node2D

onready var Goblin = load("res://Enemy/Goblin.tscn")

func _physics_process(_delta):
	if not has_node("Goblin"):
		var goblin = Goblin.instance()
		add_child(goblin)
		goblin.name = 'Goblin'
