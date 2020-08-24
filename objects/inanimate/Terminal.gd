extends Area2D

class_name Terminal

var off_sprite = Rect2(160, 192, 16, 32)
var on_sprite = Rect2(176, 192, 16, 32)

var is_on = false

var valid_on_tip_message = "Terminal\nZ: Power On"
var valid_off_tip_message = "Terminal\nZ: Power Off"
var invalid_tip_message = "Error: Permission Denied"

export (String) var valid_character = "robot1"

func _ready():
	$Sprite.region_rect = off_sprite

func interact(player):
	if player.character == valid_character:
		$SoundEffect2D.play()
		
		if is_on:
			$Sprite.region_rect = off_sprite
			$ControlTip.text = valid_on_tip_message
			GameVariables.terminals_activated -= 1
		else:
			$Sprite.region_rect = on_sprite
			$ControlTip.text = valid_off_tip_message
			GameVariables.terminals_activated += 1
			
		is_on = !is_on

func _on_Terminal_body_entered(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(self)
		
		if body.character == valid_character:
			if $Sprite.region_rect == on_sprite:
				$ControlTip.text = valid_off_tip_message
			else:
				$ControlTip.text = valid_on_tip_message
		else:
			$ControlTip.text = invalid_tip_message
		
		$ControlTip.visible = true

func _on_Terminal_body_exited(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(null)
		$ControlTip.visible = false
		
