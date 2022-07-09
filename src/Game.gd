extends Node

enum {
	THRUST_LEFT,
	THRUST_RIGHT
}

const tile: float = 1000.0

var cur_score: int = 0
var asteroids := Color("#A8A5A7")

func get_game_resolution() -> Vector2:
	var width: float = ProjectSettings.get_setting("display/window/size/width")
	var height: float = ProjectSettings.get_setting("display/window/size/height")
	
	return Vector2(width, height)

func _input(event):
	if OS.get_name() == "HTML5":
		return
	if event.is_pressed() and event is InputEventKey and event.scancode == KEY_R:
		rune_restart_game()

func game_over():
	if OS.get_name() == "HTML5":
		Rune.game_over()

func get_challenge_number():
	if OS.get_name() == "HTML5":
		return Rune.get_challenge_number()
	return 0

func _ready():
	if OS.get_name() == "HTML5":
		Rune.init(self)

func rune_resume_game():
	get_tree().paused = false

func rune_pause_game():
	get_tree().paused = true

func rune_restart_game():
	get_tree().reload_current_scene()

func rune_get_score():
	return cur_score
