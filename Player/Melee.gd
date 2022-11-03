extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Melee")

func physics_process(_delta):
	if not player.animating:
		var melee = player.get_node("Melee/Attack")
		if melee.is_colliding():
			var enemy = melee.get_collider()
			if enemy.has_method("damage"):
				enemy.damage(player.melee)
		SM.set_state("Idle")
