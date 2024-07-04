extends ParallaxBackground

var speed = 1000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.x -= delta * speed
