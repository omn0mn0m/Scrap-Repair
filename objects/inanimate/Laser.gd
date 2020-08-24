extends Area2D

func _ready():
	$AnimationPlayer.play("laser")

func toggle():
	$SoundEffect2D.play()
	$LaserBeam.visible = !$LaserBeam.visible
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled

func _on_Laser_body_entered(body):
	if body.has_method("die"):
		body.die()
