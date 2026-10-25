extends Control

func _ready() -> void:
	visible = false

func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused
