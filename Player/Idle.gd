extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.velocity = Vector2.ZERO
	player.set_animation("Idle")

func physics_process(_delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		SM.set_state("Moving")
	if Input.is_action_pressed("up"):
		SM.set_state("Jumping")
	if Input.is_action_pressed("dash"):
		SM.set_state("Dashing")
	if Input.is_action_pressed("melee"):
		SM.set_state("Melee")
