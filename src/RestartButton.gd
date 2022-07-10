extends TouchScreenButton

func _ready():
	Game.connect("show_restart", self, "_on_show_restart")

func _on_show_restart():
	visible = true

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
