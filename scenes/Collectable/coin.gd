extends Area2D

# Этот код отвечает за увеличение счётчика монет, когда игрок касается объекта,
# а также за анимацию исчезновения этого объекта с экрана.

func _on_body_entered(body):
	if body.name == "Player":
		Global.coins_on_level += 1
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 70), 0.4)
		tween1.tween_property(self, "modulate:a", 0, 0.4)
		tween1.tween_callback(queue_free)
		
