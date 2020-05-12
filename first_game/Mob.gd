extends RigidBody2D

export var min_speed = 150  # Minimum speed range.
export var max_speed = 250  # Maximum speed range.


func _ready():
	$AnimatedSprite.animation = "default"

func _process(delta):
	$AnimatedSprite.rotate(delta)

func _on_Visibility_screen_exited():
	queue_free()

func _on_start_game():
	queue_free()
