extends CharacterBody2D
class_name Player

var speed = 800


func _ready() -> void:
    Events.top_wall_hit.connect(on_top_wall_hit)


func _process(_delta: float) -> void:

    velocity.x = Input.get_axis("ui_left", "ui_right") * speed
    move_and_slide()
        

func on_top_wall_hit():
    if scale.x >= 0.5:
        var new_x = scale.x - 0.1
        var tween = get_tree().create_tween()
        tween.tween_property(self, "scale", Vector2(new_x, scale.y), 0.5)
        