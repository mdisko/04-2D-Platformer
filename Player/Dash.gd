extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

var reset_collision = 0

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Dashing")
	reset_collision = player.collision_layer
	player.collision_layer = 1
	player.collision_mask = 1
	$Timer.start()

func physics_process(_delta):
	player.velocity.x = player.direction*player.dashing
	player.move_and_slide(player.velocity, Vector2.UP)


func _on_Timer_timeout():
	player.collision_layer = reset_collision
	player.collision_mask = reset_collision
	SM.set_state("Idle")
