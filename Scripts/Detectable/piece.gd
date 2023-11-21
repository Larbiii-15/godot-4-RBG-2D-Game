extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("Active") # pour rendre mon piece active qui bouge


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body): # créer un signal que je connecté sur ma piece pour détecter mon player
	if body.name == "Player":  # càd si mon objet s'appelle player
		player_data.coin += 1
		print(player_data.coin)
		$anim.play("collecte")
		await $anim.animation_finished # attendre que mon animation fini pou que je peux supprimer l'objet (= queue_free)
		queue_free()
