extends Control


@onready var main_scene = preload("res://scenes/main.tscn")

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
