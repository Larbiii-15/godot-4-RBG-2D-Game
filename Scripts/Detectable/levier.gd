extends Area2D


func _on_area_entered(area):
	if area.name == "Sword":
		player_data.porte_ouverte = true
		$anim.play("opening")
		await $anim.animation_finished
		$anim.play("opened")
