extends KinematicBody2D

var player = null
export var speed = 2
export var damage = 10
var direction = 1
var health = 10
var max_health = 10
var velocity = Vector2.ZERO

var points = [100]
const margin = 1.5

func _ready():
	position = Vector2(500,565)

func damage(d):
	health -= d
	if health <= 0:
		queue_free()
	Global.health -= d

func _physics_process(_delta):
	if direction < 0 and !$AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if direction > 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
		
	velocity.x += direction
	move_and_slide(velocity, Vector2.UP)


func _on_Area2D_body_entered(body):
	print("left")
	if velocity.x != 0 and (body.name == "TileMap"):
		velocity.x = 0
		direction = 1
	if body.name == 'Player':
		Global.decrease_health(damage)


func _on_Area2D2_body_entered(body):
	print("right")
	if velocity.x != 0 and (body.name == "TileMap"):
		velocity.x = 0
		direction = -1
	if body.name == 'Player':
		Global.decrease_health(damage)
