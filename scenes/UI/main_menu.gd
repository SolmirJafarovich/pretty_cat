extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer

func _process(delta):
	if !audio_stream_player.playing:
		audio_stream_player.play()

func _on_new_game_pressed():
	new_game()
	get_tree().change_scene_to_file("res://scenes/Hub/hub.tscn")

func _on_resume_pressed():
	load_game()
	get_tree().change_scene_to_file("res://scenes/Hub/hub.tscn")

func new_game():
	#Состояние котёнка
	Global.lives = 9
	Global.coins = 0
	# Информация о уровне
	Global.coins_in_maze = Global.max_coins_in_maze
	Global.coins_in_platformer_lite = Global.max_coins_in_platformer_lite
	Global.coins_in_platformer_normal = Global.max_coins_in_platformer_normal
	Global.coins_in_platformer_hard = Global.max_coins_in_platformer_hard
	Global.now = Global.max
	# Покупочки
	Global.pomelo = 0
	Global.chocolate = 0
	# Секретики
	Global.chippi_chippi = false
	Global.tomato = false
	Global.happy_cat = false
	Global.winx = false
	Global.nose_taping = false
	
	
func load_game():
	var file = FileAccess.open(Global.save_path, FileAccess.READ)
	#Состояние котёнка
	Global.lives = file.get_var(Global.lives)
	Global.coins = file.get_var(Global.coins)
	# Информация о уровне
	Global.coins_in_maze = file.get_var(Global.coins_in_maze)
	Global.coins_in_platformer_lite = file.get_var(Global.coins_in_platformer_lite)
	Global.coins_in_platformer_normal = file.get_var(Global.coins_in_platformer_normal)
	Global.coins_in_platformer_hard = file.get_var(Global.coins_in_platformer_hard)
	Global.now = file.get_var(Global.now)
	# Покупочки
	Global.pomelo = file.get_var(Global.pomelo)
	Global.chocolate = file.get_var(Global.chocolate)
	# Секретики
	Global.chippi_chippi = file.get_var(Global.chippi_chippi)
	Global.tomato = file.get_var(Global.tomato)
	Global.happy_cat = file.get_var(Global.happy_cat)
	Global.winx = file.get_var(Global.winx)
	Global.nose_taping = file.get_var(Global.nose_taping)


func _on_quit_pressed():
	get_tree().quit()
