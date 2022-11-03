extends KinematicBody2D

var player = null
export var speed = 1
export var damage = 10
var direction = 1
var health = 20
var velocity = Vector2.ZERO

var points = [50]
const margin = 1.5

func _ready():
	position = Vector2(500,565)

func _physics_process(_delta):
	if direction < 0 and !$AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = true
	if direction > 0 and $AnimatedSprite.flip_h:
		$AnimatedSprite.flip_h = false
		
		
	velocity.x += direction * speed
	move_and_slide(velocity, Vector2.UP)


func _on_Area2D_body_entered(body):
	if velocity.x != 0 and (body.name == "TileMap"):
		velocity.x = 0
		direction = 1
	if body.name == 'Player':
		body.die()
		queue_free()


func _on_Area2D2_body_entered(body):
	if velocity.x != 0 and (body.name == "TileMap"):
		velocity.x = 0
		direction = -1
	if body.name == 'Player':
		body.die()
		queue_free()

