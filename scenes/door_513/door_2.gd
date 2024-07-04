extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		body.enter_room = true
		Global.what_the_level = "platformer_lite"
		body.what_the_room = "res://scenes/Platformer/platformer_lite.tscn"
		
		
func _on_body_exited(body):
	if body.name == "Player":
		body.enter_room = false
