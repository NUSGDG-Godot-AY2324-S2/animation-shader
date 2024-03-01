extends Area2D
class_name Bullet

var is_rightwards: bool = true
const SPEED: int = 3000

const DAMAGE: int = 10

func set_parameters(is_rightwards: bool, position: Vector2):
	self.is_rightwards = is_rightwards
	self.position = position
	if not is_rightwards:
		$AnimatedSprite2D.scale.x = -abs($AnimatedSprite2D.scale.x)


func _physics_process(delta):
	var x_velocity = (1 if is_rightwards else -1) * SPEED
	position.x += x_velocity * delta


func _on_exist_timer_timeout():
	queue_free()


func _on_body_entered(body):
	body.take_damage(DAMAGE)
	queue_free()
