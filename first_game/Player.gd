extends Area2D
signal hit

export var speed = 300  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var running = Input.is_action_pressed("ui_run")
	$AnimatedSprite.play()
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if velocity.length() > 0:
		if running:
			velocity = velocity.normalized() * (speed*1.8)
		else:
			velocity = velocity.normalized() * speed

	_check_sprite_direction(velocity, $AnimatedSprite)

	position += velocity * delta

	if velocity.x != 0:
		if Input.is_action_pressed("ui_run"):
			$AnimatedSprite.animation = "running"
		else:
			$AnimatedSprite.animation = "right"
		# See the note below about boolean assignment
	else:
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()


func _check_sprite_direction(velocity, sprite):
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false


func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
