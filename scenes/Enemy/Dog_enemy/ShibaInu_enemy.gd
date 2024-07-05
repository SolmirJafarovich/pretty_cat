extends CharacterBody2D

signal hp_changed(new_hp)

const SPEED = 250.0 
const push_forse = 0.5
var chase = false
var alive = true
var Damage = 30

# Получаем значение гравитации из настроек проекта для синхронизации с узлами RigidBody.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim := $AnimatedSprite2D

# Обработка физики персонажа
func _physics_process(delta):
	# Добавляем гравитацию.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Проверяем наличие игрока в сцене и определяем направление к нему.
	if $"../../Player/Player" != null:
		var player = $"../../Player/Player"
		var direction = (player.position - self.position).normalized()
		# Если погоня активна и персонаж жив, перемещаем его в направлении игрока.
		if chase and alive:
			velocity.x = direction.x * SPEED
		
		# Анимация движения в зависимости от направления.
		if velocity.x >= 1 and alive:
			anim.play("running_right")
		elif velocity.x <= -1 and alive:
			anim.play("running_left")
		else:
			if alive:
				anim.play("idle")

	# Перемещаем и обрабатываем столкновения.
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		# Если столкновение с RigidBody2D, применяем к нему импульс.
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_forse)

# Обработка смерти персонажа при столкновении с игроком.
func _on_death_body_entered(body):
	if body.name == "Player":
		alive = false
		anim.play("death")
		# Ждем завершения анимации смерти и удаляем объект.
		await anim.animation_finished
		queue_free()

# Обработка атаки персонажа при столкновении с игроком.
func _on_attack_body_entered(body):
	if body.name == "Player" and alive:		
		Global.HP -= Damage
		emit_signal("hp_changed", Global.HP)

# Обработка начала погони при входе игрока в зону обнаружения.
func _on_detector_body_entered(body):
	if body.name == "Player":
		chase = true

# Обработка окончания погони при выходе игрока из зоны обнаружения.
func _on_detector_body_exited(body):
	if body.name == "Player":
		chase = false
