extends StaticBody2D
class_name Brick

@export var level : int
var color : Color = Color(255,100,255,1)


func _ready() -> void:
	Events.collided_with_brick.connect(on_brick_hit_by_ball)
	if level == 0:
		color = Color(0.89,0.255,0.067,1)
	elif level == 1:
		color = Color(0.235, 0.768, 0.184,1)
	else:
		color = Color(0.156,0.365,0.831,1)
	$"./Sprite2D".modulate = color


func on_brick_hit_by_ball(body):
	if body.get_instance_id() == get_instance_id():
		queue_free()