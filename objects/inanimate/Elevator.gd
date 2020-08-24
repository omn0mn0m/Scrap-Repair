extends Node2D

const IDLE_DURATION = 1.0

export (Vector2) var move_to = Vector2.RIGHT * 192
export (float) var speed = 3.0
export (bool) var move_enabled = false

var follow = Vector2.ZERO

onready var platform = $Platform
onready var tween = $MovementTween

func _ready():
	pass
	
func toggle():
	if not move_enabled:
		move_enabled = true
		_init_tween()
	
func _init_tween():
	var duration = move_to.length() / float(speed * 16) # 16 is the unit size
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, IDLE_DURATION)
	tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + IDLE_DURATION * 2)
	tween.start()

func _physics_process(delta):
	if move_enabled:
		platform.position = platform.position.linear_interpolate(follow, 0.075)
