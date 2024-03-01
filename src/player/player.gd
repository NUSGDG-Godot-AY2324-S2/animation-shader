extends CharacterBody2D

const HORIZONTAL_SPEED: int = 1500
const JUMP_STRENGTH: int = 5000
const GRAVITATIONAL_STRENGTH: int = 200
const DASH_SPEED: int = 2500
var is_rightwards: bool = true
enum STATE {IDLE, WALK, JUMP, DASH}
var movement_state: STATE = STATE.IDLE
var dash_used: bool = false

const MAX_HEALTH: int = 100
var health: int = MAX_HEALTH

var can_attack: bool = true
const BulletResource = preload("res://player/skills/bullet.tscn")


func _physics_process(delta):
	make_movement()
	dash()
	save_direction()
	adjust_animation()
	attack()


func make_movement():
	if movement_state == STATE.DASH:
		velocity.x = (1 if is_rightwards else -1) * DASH_SPEED
		velocity.y = 0
		move_and_slide()
		return
	
	var x_direction: int = Input.get_action_strength("ui_right") - \
		Input.get_action_strength("ui_left")
	var is_jumping: bool = is_on_floor() and Input.is_action_just_pressed("ui_jump")
	velocity.x = x_direction * HORIZONTAL_SPEED
	velocity.y = -JUMP_STRENGTH if is_jumping else velocity.y + GRAVITATIONAL_STRENGTH
	movement_state = STATE.JUMP if not is_on_floor() else STATE.IDLE \
		if x_direction == 0 else STATE.WALK
	move_and_slide()


func save_direction():
	if velocity.x > 0:
		is_rightwards = true
	elif velocity.x < 0:
		is_rightwards = false


func dash():
	if is_on_floor():
		dash_used = false
	if not Input.is_action_just_pressed("ui_dash") or movement_state == STATE.DASH \
		or dash_used:
		return
	dash_used = true
	movement_state = STATE.DASH
	$DashTimer.start()


func _on_dash_timer_timeout():
	movement_state = STATE.IDLE


func adjust_animation():
	match movement_state:
		STATE.IDLE:
			attempt_animation("idle")
		STATE.WALK:
			attempt_animation("walk")
		STATE.JUMP:
			attempt_animation("jump")
		STATE.DASH:
			attempt_animation("dash")
	if is_rightwards:
		$AnimatedSprite2D.scale.x = 1
	else:
		$AnimatedSprite2D.scale.x = -1


func attempt_animation(anim: StringName):
	if $AnimatedSprite2D.animation != anim:
		$AnimatedSprite2D.play(anim)


func take_damage(damage: int):
	health -= 10
	print("health left ", health)
	if health < 0:
		die()


func die():
	queue_free()


func attack():
	if not Input.is_action_just_pressed("ui_attack") or not can_attack:
		return
	can_attack = false
	$AttackTimer.start()
	var bullet: Bullet = BulletResource.instantiate()
	bullet.set_parameters(is_rightwards, position)
	get_parent().add_child(bullet)


func _on_attack_timer_timeout():
	can_attack = true
