extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func actif():
	$anim.play("actif")
	await $anim.animation_finished    # Forcer godot à jouer l'animation entière et ne pas passer à une autre animation

func inactif():
	$anim.play("inactif")
	await $anim.animation_finished


func _on_body_entered(body):
	if body.name == "Player":
		player_data.health -= 1 # on perd une vie "un coeur" quand notre joeur entre en contact avec spikes "pointes".
