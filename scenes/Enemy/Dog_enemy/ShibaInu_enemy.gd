extends CharacterBody2D

signal hp_changed(new_hp)

const SPEED = 250.0 
const push_forse = 0.5
var chase = false
var alive = true
var Damage = 30

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim := $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if $"../../Player/Player" != null:
		var player = $"../../Player/Player"
		var direction = (player.position - self.position).normalized()
		if chase and alive:
			velocity.x = direction.x * SPEED
			
		if velocity.x >= 1 and alive:
			anim.play("running_right")
		elif velocity.x <= -1 and alive:
			anim.play("running_left")
		else:
			if alive:
				anim.play("idle")

	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_forse)



func _on_death_body_entered(body):
	if body.name == "Player":
		alive = false
		anim.play("death")
		await anim.animation_finished
		queue_free()


func _on_attack_body_entered(body):
	if body.name == "Player" and alive:		
		Global.HP -= Damage
		emit_signal("hp_changed", Global.HP)


func _on_detector_body_entered(body):
	if body.name == "Player":
		chase = true
		

func _on_detector_body_exited(body):
	if body.name == "Player":
		chase = false
