extends CanvasLayer

export (NodePath) var player_path

onready var player = get_node(player_path)

func _process(delta):
	$ScoreLabel.text = str(Game.cur_score)
	$HealthBar.value = player.health
	$RingCount.num_rings = player.rings
