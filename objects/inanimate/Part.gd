extends Area2D

func interact(player):
	player.parts_held += 1
	$SoundEffect2D.play()
	
func _on_Part_body_entered(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(self)
		$ControlTip.visible = true

func _on_Part_body_exited(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(null)
		$ControlTip.visible = false

func _on_SoundEffect_finished():
	self.queue_free()
