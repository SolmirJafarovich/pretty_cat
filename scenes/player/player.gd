extends CharacterBody2D

signal hp_changed(new_hp)

const SPEED = 350.0 
const JUMP_VELOCITY = -600.0
const push_forse = 0.5
var enter_room = false
var what_the_room
var level_finished = false
var alive = true
var shop_offer = false

# Получаем значение гравитации из настроек проекта для синхронизации с узлами RigidBody.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim := $AnimatedSprite2D
@onready var camera_2d = $Camera2D

# Инициализация начального состояния
func _ready():
	Global.player_position = position

# Обработка физики персонажа
func _physics_process(delta):
	if alive:
		# Добавляем гравитацию.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Обработка прыжка.
		if Input.get_axis("up", "ui_down") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Получаем направление ввода и обрабатываем движение/замедление.
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		# Анимация движения в зависимости от направления.
		if velocity.x >= 1:
			anim.play("running_right")
		elif velocity.x <= -1:
			anim.play("running_left")
		else:
			anim.play("idle")

		move_and_slide()
		
		# Обработка столкновений с другими объектами
		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				c.get_collider().apply_central_impulse(-c.get_normal() * push_forse)

# Обработка различных действий игрока в процессе игры
@warning_ignore("unused_parameter")
func _process(delta):
	if Input.is_action_just_pressed("restart_level"):
		Global.coins_on_level = 0
		Global.HP = 100
		emit_signal("hp_changed", Global.HP)
		get_tree().reload_current_scene()
		
	if Input.is_action_pressed("zoom"):
		zoom()
	else:
		not_zoom()

	if Global.HP < 0:
		death()
		
	if enter_room == true and Input.is_action_just_pressed("use"):
		use_door()
			
	if level_finished and Input.is_action_just_pressed("use"):
		exit_level()
	
	if shop_offer and Input.is_action_just_pressed("use"):
		buy()

# Обработка смерти персонажа
func death():
	alive = false
	anim.play("death")
	Global.lives -= 1
	Global.coins_on_level = 0
	Global.HP = 100
	emit_signal("hp_changed", Global.HP)
	await anim.animation_finished
	get_tree().reload_current_scene()
	alive = true

# Увеличение масштаба камеры
func zoom():
	camera_2d.zoom.x = 0.7
	camera_2d.zoom.y = 0.7

# Восстановление масштаба камеры
func not_zoom():
	camera_2d.zoom.x = 1
	camera_2d.zoom.y = 1

# Обработка использования двери
func use_door():
	Global.player_position = self.position
	Global.coins_on_level = 0
	Global.HP = 100
	emit_signal("hp_changed", Global.HP)
	get_tree().change_scene_to_file(what_the_room)

# Обработка покупки в магазине
func buy():
	if Global.what_the_product == "pomelo" and Global.coins >= 25:
		Global.coins -= 25
		Global.pomelo += 1
	elif Global.what_the_product == "chocolate" and Global.coins >= 15:
		Global.coins -= 15
		Global.chocolate += 1

# Обработка завершения уровня
func exit_level():
	var temp = 0
	if Global.what_the_level == "maze":
		temp = min(Global.coins_in_maze, Global.coins_on_level)
		Global.coins_in_maze -= temp
	elif Global.what_the_level == "platformer_lite":
		temp = min(Global.coins_in_platformer_lite, Global.coins_on_level)
		Global.coins_in_platformer_lite -= temp
	elif Global.what_the_level == "platformer_normal":
		temp = min(Global.coins_in_platformer_normal, Global.coins_on_level)
		Global.coins_in_platformer_normal -= temp
	elif Global.what_the_level == "platformer_hard":
		temp = min(Global.coins_in_platformer_hard, Global.coins_on_level)
		Global.coins_in_platformer_hard -= temp
	elif Global.what_the_level == "maze_bigger":
		temp = min(Global.now, Global.coins_on_level)
		Global.now -= temp

	Global.coins += temp
	Global.coins_on_level = 0
	Global.HP = 100
	emit_signal("hp_changed", Global.HP)
	get_tree().change_scene_to_file("res://scenes/Hub/hub.tscn")
