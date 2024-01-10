extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		player_data.coin += 1
		queue_free()
