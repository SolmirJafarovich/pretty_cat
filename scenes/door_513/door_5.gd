extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		body.enter_room = true
		body.what_the_room = "res://scenes/Hub/shop.tscn"
		
func _on_body_exited(body):
	if body.name == "Player":
		body.enter_room = false
