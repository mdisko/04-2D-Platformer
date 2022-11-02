extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	if Input.is_action_just_released("dash"):
		SM.set_state("Moving")
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		player.set_animation("Moving")
		var input_vector = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),0)
		player.velocity += player.move_speed * input_vector
		player.move_and_slide(player.velocity, Vector2.UP)
	else:
		player.velocity.x = 0
		SM.set_state("Moving")
