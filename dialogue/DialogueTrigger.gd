extends Area2D

export (String) var part = "0"
export (bool) var is_game_message = false
export (int) var duration = 3

func _on_DialogueTrigger_body_entered(body):
	if body.has_method("show_dialogue_part"):
		body.show_dialogue_part(part, is_game_message, duration)
		body.respawn_point = global_position
		self.queue_free()
