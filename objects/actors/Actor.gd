extends KinematicBody2D

# Class for gravity-bound moving objects
class_name Actor

export var speed = Vector2(125.0, 400.0)
export var gravity = 1000.0

const FLOOR_NORMAL = Vector2.UP

var _velocity = Vector2.ZERO

# Shared gravity step
func _physics_process(delta):
	_velocity.y += gravity * delta
