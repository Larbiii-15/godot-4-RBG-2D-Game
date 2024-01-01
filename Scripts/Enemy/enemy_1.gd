extends entity_movement


func _ready():
	random_direction() # on appelle la fonction random ici de la script entity.gd
# Timer : Nouveau node --> en fin de la décomptage, on va actionner on va appeler notre fonction random direction

func _on_timer_timeout():
	random_direction()
	$Timer.start()    # On va relancer le time start qui va créer une boucle qui va donc à chaque fois changer la direction de notre personnage


func _on_hitbox_area_entered(area):
	if area.name == "Sword":  # Enlever de la vie de notre ennemi après un attaque
		flash() # la fonction qui appelle l'effet shader créer au début à notre player
		health -= 1
		print(health)


