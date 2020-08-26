extends ToggleItem

var robot1_off_sprite = Rect2(160, 16, 16, 16)
var robot1_on_sprite = Rect2(160, 0, 16, 16)

var robot2_off_sprite = Rect2(160, 48, 16, 16)
var robot2_on_sprite = Rect2(160, 32, 16, 16)

var valid_tip_message = "Button\nZ: Activate"
var invalid_tip_message = "Error: Permission Denied"

export (String) var valid_character = "robot1"

# Called when the node enters the scene tree for the first time.
func _ready():
	if valid_character == "robot1":
		$Sprite.region_rect = robot1_on_sprite
	else:
		$Sprite.region_rect = robot2_on_sprite

func interact(player):
	if player.character == valid_character:
		for child in get_children():
			if child.has_method("toggle"):
				child.toggle()
				
		if $Sprite.region_rect == robot1_on_sprite:
			$Sprite.region_rect = robot1_off_sprite
		elif $Sprite.region_rect == robot1_off_sprite:
			$Sprite.region_rect = robot1_on_sprite
		elif $Sprite.region_rect == robot2_on_sprite:
			$Sprite.region_rect = robot2_off_sprite
		elif $Sprite.region_rect == robot2_off_sprite:
			$Sprite.region_rect = robot2_on_sprite
			
	$SoundEffect2D.play()

func _on_Button_body_entered(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(self)
		
		if body.character == valid_character:
			$ControlTip.text = valid_tip_message
		else:
			$ControlTip.text = invalid_tip_message
		
		$ControlTip.visible = true

func _on_Button_body_exited(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(null)
		$ControlTip.visible = false
		
