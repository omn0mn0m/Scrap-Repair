extends Actor

# Player class adapted from GDQuest 2D Platformer demo
class_name Player

onready var chat = $ChatBubble/Dialogue

const FLOOR_DETECT_DISTANCE = 40.0

var interactable_object = null

var lang = "en"

var dialogue_file_path = "res://dialogue/Dialogue.json"
var dialogue

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogue_file = File.new()
	dialogue_file.open(dialogue_file_path, dialogue_file.READ)
	var json = dialogue_file.get_as_text()
	dialogue = JSON.parse(json).result
	print(dialogue)
	dialogue_file.close()
	
	$AnimationPlayer.play("idle")
	
# Called when input is pressed
func _input(event):
	if event.is_action_pressed("interact"):
		if interactable_object != null:
			interact_with()

# Called every physics tick
func _physics_process(delta):
	var direction = get_direction()
	
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0

	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	
	var snap_vector = Vector2.DOWN * 20 if direction.y == 0.0 else Vector2.ZERO
	
	var is_on_platform = $PlatformDetector.is_colliding()
	
	_velocity = move_and_slide_with_snap(
		_velocity, snap_vector, FLOOR_NORMAL, is_on_platform, 4,  0.9, false
	)
	
	if direction.x != 0:
		$Sprite.scale.x = direction.x
		
		if direction.x > 0:
			$HoldPosition2D.position.x = 25
		else:
			$HoldPosition2D.position.x = -25

	set_animation()
	
func interact_with():
	interactable_object.interact(self)
	
func set_animation():
	if is_on_floor():
		if _velocity.x != 0:
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("idle")
	
func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)

func calculate_move_velocity(
		linear_velocity,
		direction,
		speed,
		is_jump_interrupted
	):
	
	var velocity = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
	return velocity

func set_interactable_object(object):
	if interactable_object != null and interactable_object.has_method("is_held"):
		if not interactable_object.is_held():
			interactable_object = object
	else:
		interactable_object = object

func show_dialogue_part(part):
	chat.text = dialogue[part][lang]
	$DialogueTimer.start()

func _on_DialogueTimer_timeout():
	chat.text = ""
