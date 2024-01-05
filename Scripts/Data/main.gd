extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if player_data.last_position != null :
		$Player.global_position = player_data.last_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
