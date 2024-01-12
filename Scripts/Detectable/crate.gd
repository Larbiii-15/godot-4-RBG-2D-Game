extends StaticBody2D
@onready var key_loot = preload("res://Scenes/Detectable/key.tscn") # référence à ma scène clé 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_hitbox_area_entered(area):
	if area.is_in_group("sword"):  # Enlever de la vie de notre ennemi après un attaque
		$anim.play("Destroyed") # jouer une animation  
		await $anim.animation_finished # attendre que l'animation fini pour qu'on atteindre notre objet
		looting()
		queue_free() # fct construit par godot permet d'enlever des objets de notre jeu 

func looting(): # permet d'accéder à différents éléments 
	var cle = key_loot.instantiate() # permet d'instancier donc charger notre clé quand notre ennemi va mourir
	cle.global_position = global_position # permettre de pouvoir établir la position de notre pièce en fonction de la position de notre ennemi
	get_tree().get_root().add_child(cle)
