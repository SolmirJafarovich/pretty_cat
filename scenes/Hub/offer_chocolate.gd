extends Area2D



func _on_body_entered(body):
	if body.name == "Player":
		body.shop_offer = true
		Global.what_the_product = "chocolate"


func _on_body_exited(body):
	if body.name == "Player":
		body.shop_offer = false
