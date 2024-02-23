extends StaticBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_detecteur_body_entered(body):
	if body.name == "Player":
		$Sprite2D.self_modulate.a = 0.50
		# Lance le chronomètre après une certaine durée
		$WinTimer.start()

func _on_detecteur_body_exited(body):
	if body.name == "Player":
		$Sprite2D.self_modulate.a = 1
# Dans le script associé au détecteur


func _on_win_timer_timeout():
	get_tree().change_scene("res://Scenes/UI/menu_screen.tscn")
