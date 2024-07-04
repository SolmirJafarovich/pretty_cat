extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		body.level_finished = true
		body.what_the_room = "res://scenes/Hub/hub.tscn"


func _on_body_exited(body):
	if body.name == "Player":
			body.level_finished = false


