extends Node

enum {
	THRUST_LEFT,
	THRUST_RIGHT
}

const tile: float = 2000.0

var asteroids := Color("#A8A5A7")

func get_game_resolution() -> Vector2:
	var width: float = ProjectSettings.get_setting("display/window/size/width")
	var height: float = ProjectSettings.get_setting("display/window/size/height")
	
	return Vector2(width, height)
