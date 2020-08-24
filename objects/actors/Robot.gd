extends Actor

class_name Robot

var robot1_on_sprite = Rect2(208, 16, 16, 32)
var robot2_on_sprite = Rect2(208, 48, 16, 32)

var robot1_off_sprite = Rect2(432, 16, 16, 32)

var robot2_off_sprite = Rect2(432, 48, 16, 32)
var robot2_off_1leg_sprite = Rect2(448, 48, 16, 32)
var robot2_off_noleg_sprite = Rect2(464, 48, 16, 32)
var robot2_off_noleg_nobackpack_sprite = Rect2(480, 48, 16, 32)
var robot2_off_noleg_nobackpack_noface_sprite = Rect2(496, 48, 16, 32)

var robot1_missing_parts = 0
var robot2_missing_parts = 4

var started_futility_countdown = false

var attach_part_tip_message = "Z: Attach Part"
var attach_battery_tip_message = "X: Swap Batteries"

var character = "robot2"

func _physics_process(delta):
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func interact(player):
	if character == "robot1":
		pass # Here in case robot 1 needs to break in the future
	else:
		robot2_missing_parts -= player.parts_held
		player.parts_held = 0
		
		if not GameVariables.can_swap:
			$ControlTip.text = attach_part_tip_message + " \nParts Missing: " + str(robot2_missing_parts)
		
		if robot2_missing_parts == 3:
			$Sprite.region_rect = robot2_off_noleg_nobackpack_sprite
		elif robot2_missing_parts == 2:
			$Sprite.region_rect = robot2_off_noleg_sprite
		elif robot2_missing_parts == 1:
			$Sprite.region_rect = robot2_off_1leg_sprite
		elif robot2_missing_parts == 0:
			$Sprite.region_rect = robot2_off_sprite
			
			player.show_dialogue_part("PartsFound", false, 3)
			
			if not started_futility_countdown:
				player.futility_timer.start()
				started_futility_countdown = true
				
			if player.has_battery:
				$Sprite.region_rect = robot2_on_sprite
				$ChatBubble.visible = true

func swap(player):
	if robot2_missing_parts == 0 and robot1_missing_parts == 0:
		var temp_char = player.character
		var temp_pos = player.position
		
		player.character = character
		character = temp_char
		
		if character == "robot1":
			$Sprite.region_rect = robot1_off_sprite
		else:
			$Sprite.region_rect = robot2_off_sprite

func _on_Area2D_body_entered(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(self)
		
		if character == "robot1":
			pass # In case robot 1 needs to break in the future
		else:
			if GameVariables.can_swap:
				$ControlTip.text = attach_battery_tip_message
			else:
				$ControlTip.text = attach_part_tip_message + " \nParts Missing: " + str(robot2_missing_parts)
			
			$ControlTip.visible = true

func _on_Area2D_body_exited(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(null)
		$ControlTip.visible = false
