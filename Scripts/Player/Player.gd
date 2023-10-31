extends CharacterBody2D

enum player_states {MOVE,JUMP,SWORD, DEAD} #state machine
var current_states = player_states.MOVE

@onready var anim_tree = $anim_tree  # pour accéder directement au contenu anim_tree
@onready var anim_state = anim_tree.get("parameters/playback") # pour qu'il consulte nos paramètres créer dans anim (Jump, Move ...)

@export var vitesse = 50                  # créer un variable vitesse qui avance avec 50 pixels a chaque fois
var input_movement = Vector2()    # créer un variable pour les mvts sur les axes X et Y

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


func move():
	
	input_movement = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	# c à d qu'on a appuyer sur un touche
	if input_movement != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_movement) # set pour obtenir les info dans paramètres cà d indiquez leur place
		anim_tree.set("parameters/Jump/blend_position", input_movement)
		anim_tree.set("parameters/Move/blend_position", input_movement)
		anim_tree.set("parameters/Sword/blend_position", input_movement)
		anim_state.travel("Move") # pour le demandez d'apliquez ces paramètres
		velocity = input_movement * vitesse
	
	if input_movement == Vector2.ZERO:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
	if Input.is_action_just_pressed("ui_sword"): # càd qd tu click sur un button X cette input va exécuter sword "l'attaque" (ui_sword créer dans input map dans projet settings)
		current_states = player_states.SWORD
		
		
	move_and_slide()   # fct permet d'appliquer les mouvements
	
func sword():
	anim_state.travel("Sword") # ici on va jouer notre animation
	
func on_states_reset(): # pour changer le state sword en state move aprés la fin d'un cycle d'attaque (right,left,up,down)
	current_states = player_states.MOVE
