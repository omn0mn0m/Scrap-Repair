extends KinematicBody2D

var grey_cube_sprite = Rect2(112, 208, 16, 16)
var pink_cube_sprite = Rect2(128, 208, 16, 16)
var blue_cube_sprite = Rect2(144, 208, 16, 16)

enum CUBE_TYPE {
	GREY = 0,
	PINK = 1,
	BLUE = 2,
}

var cube_type = CUBE_TYPE.GREY

var held = false

export var gravity = 1000.0

const FLOOR_NORMAL = Vector2.UP

var _velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	if cube_type == CUBE_TYPE.BLUE:
		$Sprite.region_rect = blue_cube_sprite
	elif cube_type == CUBE_TYPE.PINK:
		$Sprite.region_rect = pink_cube_sprite
	else:
		$Sprite.region_rect = grey_cube_sprite

func _physics_process(delta):
	if held:
		position = get_parent().get_node("Player/HoldPosition2D").global_position
	else:
		_velocity.y += gravity * delta
		
		_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func interact(player):
	held = !held
	
	if not held:
		player.interactable_object = null
		
func is_held():
	return held

func _on_InteractArea2D_body_entered(body):
	if body.has_method("interact_with"):
		body.set_interactable_object(self)

func _on_InteractArea2D_body_exited(body):
	if not held:
		if body.has_method("interact_with"):
			body.set_interactable_object(null)
