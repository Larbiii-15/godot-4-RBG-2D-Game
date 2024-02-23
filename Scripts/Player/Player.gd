extends CharacterBody2D

enum player_states {MOVE,JUMP,SWORD, DEAD} #state machine
var current_states = player_states.MOVE

@onready var anim_tree = $anim_tree  # pour accéder directement au contenu anim_tree
@onready var anim_state = anim_tree.get("parameters/playback") # pour qu'il consulte nos paramètres créer dans anim (Jump, Move ...)

@export var vitesse = 50                  # créer un variable vitesse qui avance avec 50 pixels a chaque fois
var input_movement = Vector2()    # créer un variable pour les mvts sur les axes X et Y

func show_game_over():
	show_message("GAME OVER")
	
func show_message(text):
	$GameOverMessage.text = text
	$GameOverMessage.show()

func _ready():
	$sword/CollisionShape2D.disabled = true # Dés le départ de jeu ma collision shape relative à l'animation de sword va être désactivé
# fct Pour surveiller les inputs par click sur le clavier par joeur
func _physics_process(delta):
	#move() : j'ai supprimer move() pour que qd je fait un attaque le joeur va s'arrêter avant qu'il frappe (pas frappe et bouge au même temps)
	# match machine
	match current_states:
		player_states.MOVE:
			move()
		player_states.SWORD:
			sword()
		player_states.DEAD:
			dead() # on va le connecter à notre fobction dead
		player_states.JUMP:
			jump()

func input_move(): # pour que notre player marche directement après qu'il saut
	input_movement = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	# c à d qu'on a appuyer sur un touche
	if input_movement != Vector2.ZERO:
		velocity = input_movement * vitesse
	move_and_slide()

func move():
	enable_collision()
	input_movement = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	# c à d qu'on a appuyer sur un touche
	if input_movement != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_movement) # set pour obtenir les info dans paramètres cà d indiquez leur place
		anim_tree.set("parameters/Jump/blend_position", input_movement)
		anim_tree.set("parameters/Move/blend_position", input_movement)
		anim_tree.set("parameters/Sword/blend_position", input_movement)
		anim_tree.set("parameters/Dead/blend_position", input_movement)
		anim_state.travel("Move") # pour le demandez d'apliquez ces paramètres
		velocity = input_movement * vitesse
	
	if input_movement == Vector2.ZERO:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
	if Input.is_action_just_pressed("ui_sword"): # càd qd tu click sur un button X cette input va exécuter sword "l'attaque" (ui_sword créer dans input map dans projet settings)
		current_states = player_states.SWORD
	if player_data.health <= 0 : # pour gérer l'"tat mort de joeur
		current_states = player_states.DEAD # permettre de transitionner de l'étar dans lequel on se trouve à l'"tat de mort
		
	if Input.is_action_just_pressed("ui_jump"):
		current_states = player_states.JUMP
	move_and_slide()   # fct permet d'appliquer les mouvements
	
func sword():
	anim_state.travel("Sword") # ici on va jouer notre animation

func jump():
	input_move()
	anim_state.travel("Jump") # state machine (Jump)

func dead():
	$Music.stop()
	show_game_over()
	$GameOverSound.play()
	anim_state.travel("Dead") # je vais indiquer à Godot qu'il faut qu'il voyage jusqu'à mon Blade Space Dead pour pouvoir jouer l'animation
	await get_tree().create_timer(2).timeout
	player_data.health = 4 
	current_states = player_states.MOVE
	get_tree().change_scene_to_file("res://Scenes/UI/menu_screen.tscn") # va redémarer la scène dans laquelle on se trouve aprés la mort

func flash(): # fonction pour nous démontre que notre joeur est blessé(changement de coleur)
	$Sprite2D.material.set_shader_parameter("flash_modifier", 1) # donne couleur blanc à mon joeur càd blessé
	await get_tree().create_timer(0.3).timeout # temps écolué apendant la blesure avant qu'il revient à son état normal
	$Sprite2D.material.set_shader_parameter("flash_modifier", 0) # couleur 0 càd la couleur normal de notre joeur après qu'il a revenu à son état normal
func on_states_reset(): # pour changer le state sword en state move aprés la fin d'un cycle d'attaque (right,left,up,down)
	current_states = player_states.MOVE


func _on_hitbox_area_entered(area):
	if area.is_in_group("danger"): # quand on rentre en contact avec des arrières qui sont dans ce groupe danger le shader (flash) va fonctionner
		player_data.health -= 1 # on perd une vie "un coeur" quand notre joeur entre en contact avec spikes "pointes".
		flash()

func disable_collision(): # fonction permettre notre player de sauter en dessus des objets 
	$CollisionShape2D.disabled = true

func enable_collision():
	$CollisionShape2D.disabled = false 

func to_dictionary (): # qui va créer une liste a sauvegardé (la dernière position de player, le nombre de vie resté, nombre de pièce collecté)
	return {
		"position"	: [position.x , position.y],
		"health"	: player_data.health,
		"coin"		: player_data.coin,
	}

func from_dictionary(data):
	position = Vector2 (data.position[0], data.position[1])
	player_data.health = data.health
	player_data.coin = data.coin
	
func player_sell_methode():
	pass

func shop_methode():
	pass

