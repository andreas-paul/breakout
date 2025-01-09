extends CharacterBody2D
class_name Ball

var speed_initial : int = 300
var speed_multiplier : float = 1.1


func _ready() -> void:

	velocity = Vector2(randi_range(speed_initial * -1, speed_initial), speed_initial * -1)


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collision_body = collision.get_collider()
		if collision_body is Brick:
			Events.collided_with_brick.emit(collision_body)
			speed_multiplier = 1.01
		elif collision_body.name == "WallTop":
			Events.top_wall_hit.emit()
		velocity = velocity.bounce(collision.get_normal()) * speed_multiplier



	if velocity.length() > 2000:
			velocity = velocity.clamp(Vector2(-2000,-2000), Vector2(2000,2000))


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	Events.ball_left_screen.emit()
