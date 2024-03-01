extends Area2D

const DAMAGE: int = 10


func _on_body_entered(body):
	body.take_damage(DAMAGE)
