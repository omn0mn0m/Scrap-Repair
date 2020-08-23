extends Area2D

var off_sprite = Rect2(160, 192, 16, 32)
var on_sprite = Rect2(176, 192, 16, 32)

var is_on = false

func interact(player):
	if is_on:
		$Sprite.region_rect = off_sprite
	else:
		$Sprite.region_rect = on_sprite
		
	is_on = !is_on

func _on_Terminal_body_entered(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(self)

func _on_Terminal_body_exited(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(null)
