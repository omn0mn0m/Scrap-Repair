extends Area2D

func interact(player):
	GameVariables.has_battery = true
	$SoundEffect2D.play()
	
func _on_Battery_body_entered(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(self)
		$ControlTip.visible = true
	
func _on_Battery_body_exited(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(null)
		$ControlTip.visible = true
	
func _on_SoundEffect2D_finished():
	self.queue_free()
	
