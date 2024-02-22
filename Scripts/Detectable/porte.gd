extends StaticBody2D

@export var id = int()
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$b_button.visible = active 

	if player_data.porte_ouverte == true && id == 0:
		$anim.play("opening")
		await $anim.animation_finished # je lui dit d'attendre que l'annimation que j'ai créer pour démontrer l'ouverture de la porte qu'i finit avant d'appliquer ensuite "opened"
		$anim.play("opened")
		player_data.porte_ouverte == false
		
#func _input(event): # fonction qui permettre de presser la button et ouvrir la porte
#	if Input.is_action_just_pressed ("ui_dialog") && active && player_data.key >= 1 : # j'ai configuré le Button B de mon clavier pour appuyer si nécessaire d'ouvrir la porte et même si j'ai un clé collecté
#		$anim.play("opening")
#		await $anim.animation_finished # je lui dit d'attendre que l'annimation que j'ai créer pour démontrer l'ouverture de la porte qu'i finit avant d'appliquer ensuite "opened"
#		$anim.play("opened")
#		active = false
		

func _on_player_detecteur_body_entered(body): # pour afficher le button B quand notre player arrive an face de la porte
	if body.name == "Player":
		player_data.last_position = body.position
		print(player_data.last_position)
		active = true 


func _on_player_detecteur_body_exited(body): # pour le cas contraire quand le player va quitter la face de la porte le button B va désactivé (disparaître)
	if body.name == "Player":
		active = false




func _on_detecteur_body_entered(body): # fonction qui nous permettre d'entrer à l'intérieur de la maison
	if body.name == "Player" :
		get_tree().change_scene_to_file("res://Scenes/Background/interieur/interieur_maison.tscn")
		show_message("YOU WIN")
		$WinTimer.timeout
		get_tree().change_scene_to_file("res://Scenes/UI/menu_screen.tscn")
		
	
	
func show_message(text):
	$WinMesaage.text = text
	$WinMesaage.show()
