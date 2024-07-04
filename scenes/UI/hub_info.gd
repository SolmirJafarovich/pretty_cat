extends CanvasLayer

@onready var health = $Health
@onready var backpack = $backpack

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		if Input.is_action_pressed("backpack"):
			health.hide()
			backpack.show()
		else:
			health.show()
			backpack.hide()
