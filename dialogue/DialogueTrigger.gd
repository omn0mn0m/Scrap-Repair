extends Area2D

export (String) var part = "0"

func _on_DialogueTrigger_body_entered(body):
	if body.has_method("show_dialogue_part"):
		body.show_dialogue_part(part)
		self.queue_free()
