extends CanvasLayer

export (NodePath) var player_path

onready var player = get_node(player_path)

func _process(delta):
	$ScoreLabel.text = str(player.get_score())
	$HealthBar.value = player.health
