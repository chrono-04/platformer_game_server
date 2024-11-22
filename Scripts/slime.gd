extends Node2D

const speed = 60

var direction = -1

@onready var raycast_right = $"Raycast Right"
@onready var raycast_left = $"Raycast Left"
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	if raycast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if raycast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
		
	position.x += direction * speed * delta
