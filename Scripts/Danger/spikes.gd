extends Area2D


func actif():
	$anim.play("actif")
	await $anim.animation_finished    # Forcer godot à jouer l'animation entière et ne pas passer à une autre animation

func inactif():
	$anim.play("inactif")
	await $anim.animation_finished
