extends Node2D

@onready var ball = preload("res://scenes/ball.tscn")

@export var player : Player
@export var lifes : int = 3
@export var label_score : Label
@export var label_life : Label
@export var label_highscore : Label
@export var lost_screen : CenterContainer

var score : int = 0
var current_highscore : int
var json_data : Dictionary
var json_file_path : String = "user://highscore.json"


func _ready() -> void:
    Events.ball_left_screen.connect(on_ball_screen_exited)
    Events.collided_with_brick.connect(on_brick_hit_by_ball)

    current_highscore = load_highscore_from_json(json_file_path)
    label_highscore.text = str(current_highscore)

    await get_tree().create_timer(1).timeout
    add_ball()


func _process(_delta: float) -> void:
    if lifes <= 0:
        handle_highscore(score)
        print("You lost!")
        lost_screen.visible = true
        get_tree().paused = true


func on_ball_screen_exited():
    if lifes > 0:
        lifes -= 1
        label_life.text = str(lifes)
        await get_tree().create_timer(1).timeout
        add_ball()


func on_brick_hit_by_ball(_body):
    score += 1
    label_score.text = str(score)


func add_ball():
    var _ball = ball.instantiate() as CharacterBody2D
    _ball.global_position = Vector2(player.global_position.x, 544)
    add_child(_ball)


func save_highscore_to_json(file_path, score):
    var file = FileAccess.open(file_path, FileAccess.WRITE)
    var json = JSON.stringify({"highscore": score})
    file.store_string(json)


func load_highscore_from_json(file_path) -> int:
    var data = FileAccess.open(file_path, FileAccess.READ)
    var parsed_data = JSON.parse_string(data.get_as_text())
    return parsed_data["highscore"]


func handle_highscore(score: int):
    if score > current_highscore:
        save_highscore_to_json(json_file_path, score)

