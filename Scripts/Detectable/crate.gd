extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_area_entered(area):
	if area.name == "Sword":
		$anim.play("Destroyed") # jouer une animation  
		await $anim.animation_finished # attendre que l'animation fini pour qu'on atteindre notre objet
		queue_free() # fct construit par godot permet d'enlever des objets de notre jeu 
