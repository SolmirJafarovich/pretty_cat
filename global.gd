extends Node

var game_paused = false
var save_path = "user://savegame.save"
var save_path_old = "res://save/savegame.save"

#Состояние котёнка
var lives = 9
var HP = 100
var player_position
var what_the_level
var what_the_product

#Богатство котёнка
var coins = 0
var coins_on_level = 0

#Маи секретики
var chippi_chippi = false
var tomato = false
var happy_cat = false
var winx = false
var nose_taping = false

# Маи покупочки
var pomelo = 0 
var chocolate = 0

#Информация по каждому уровню

var max_coins_in_maze = 16
var coins_in_maze = 16

var max_coins_in_platformer_lite = 5
var coins_in_platformer_lite = 5

var max_coins_in_platformer_normal = 13
var coins_in_platformer_normal = 13

var max_coins_in_platformer_hard = 24
var coins_in_platformer_hard = 24

var max = 30
var now = 30

var max_coins_in_big_maze = 10
var coins_in_big_maze = 10


