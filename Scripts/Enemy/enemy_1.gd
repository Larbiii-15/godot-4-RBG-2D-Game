extends entity_movement

func _ready():
	random_direction() # on appelle la fonction random ici de la script entity.gd
# Timer : Nouveau node --> en fin de la décomptage, on va actionner on va appeler notre fonction random direction

func _on_timer_timeout():
	random_direction()
	$Timer.start()    # On va relancer le time start qui va créer une boucle qui va donc à chaque fois changer la direction de notre personnage
