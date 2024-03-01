extends CharacterBody2D

var is_rightwards: bool = true
const SPEED: int = 400

const MAX_HEALTH: int = 40
var health: int = MAX_HEALTH


func _physics_process(delta):
	velocity.x = (1 if is_rightwards else -1) * SPEED
	move_and_slide()


func _on_movement_timer_timeout():
	is_rightwards = !is_rightwards


func take_damage(damage: int):
	health -= damage
	if health < 0:
		die()


func die():
	queue_free()
