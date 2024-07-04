extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		body.enter_room = true
		Global.what_the_level = "maze_bigger"
		body.what_the_room = "res://scenes/Maze/maze_bigger.tscn"
		
		
func _on_body_exited(body):
	if body.name == "Player":
		body.enter_room = false
