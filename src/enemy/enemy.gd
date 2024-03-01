extends CharacterBody2D

var is_rightwards: bool = true
const SPEED: int = 400

const MAX_HEALTH: int = 40
var health: int = MAX_HEALTH

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta):
	velocity.x = (1 if is_rightwards else -1) * SPEED
	move_and_slide()


func _on_movement_timer_timeout():
	is_rightwards = !is_rightwards


func take_damage(damage: int):
	health -= damage
	if health < 0:
		die()
		return
	flash()


func flash():
	sprite.material.set_shader_parameter("flash_modifier", 0.8)
	$FlashTimer.start()


func die():
	queue_free()


func _on_flash_timer_timeout():
	sprite.material.set_shader_parameter("flash_modifier", 0)
