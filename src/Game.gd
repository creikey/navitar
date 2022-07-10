extends Node

enum {
	THRUST_LEFT,
	THRUST_RIGHT
}

const tile: float = 1000.0

signal show_restart

var cur_score: int = 0
var asteroids := Color("#A8A5A7")

func get_game_resolution() -> Vector2:
	var width: float = ProjectSettings.get_setting("display/window/size/width")
	var height: float = ProjectSettings.get_setting("display/window/size/height")
	
	return Vector2(width, height)

func _input(event):
	if Rune.available():
		return
	if event.is_pressed() and event is InputEventKey and event.scancode == KEY_R:
		rune_restart_game()

func game_over():
	if Rune.available():
		Rune.game_over()
	else:
		emit_signal("show_restart")

func get_challenge_number():
	if Rune.available():
		return Rune.get_challenge_number()
	# days since Saturday, July 8 2023 12:00:00 am PDT
	return floor((Time.get_unix_time_from_system() -  1657329348.0)/86400)

func _ready():
	if Rune.available():
		Rune.init(self)

func rune_resume_game():
	get_tree().paused = false

func rune_pause_game():
	get_tree().paused = true

func rune_restart_game():
	get_tree().reload_current_scene()

func rune_get_score():
	return cur_score
