extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		player_data.key += 1
		player_data.score += 50  # Ajouter 50 points par clé collectée (plus rare que les pièces)
		queue_free() # c à d supprimer notre clé 
