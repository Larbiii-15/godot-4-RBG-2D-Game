extends CharacterBody2D
class_name entity_movement

@onready var coin_loot = preload("res://Scenes/Detectable/piece.tscn")   # fonction permet d'accéder à des scènes qu'on a déjà créer
# preload est une fonction qu'on utilise pour précharger une scène qui existe déja comme la pièce dans le doc Scenes 
@onready var dead_fx = preload("res://Scenes/Dead_fx/dead_fx.tscn")
var health = 3  # nombre de vie de l'ennemi 
var current_states
enum enemy_states {MOVEUP, MOVEDOWN, MOVERIGHT, MOVELEFT, DEAD}

var dir # pour déclarer l variable de la direction
@export var speed = 50


func _ready():
	current_states = enemy_states.MOVEDOWN


func _physics_process(delta):

	if health <= 0 :
		current_states = enemy_states.DEAD
	match current_states:
		enemy_states.MOVEDOWN:
			move_down(delta)
		enemy_states.MOVEUP:
			move_up(delta)
		enemy_states.MOVELEFT:
			move_left(delta)
		enemy_states.MOVERIGHT:
			move_right(delta)
		enemy_states.DEAD:
			dead()
	
	move_and_slide()
	
func random_direction():
	dir = randi() % 4 + 1 # fonction qui permette de générer une suite de nombrs entier entre 0 et 4 // le plus 1 permettre de soustraire le zéro.
	print(dir)
	random_mouvement()
	
func random_mouvement():
	match dir:  # match statement
		1:
			current_states = enemy_states.MOVELEFT
		2:
			current_states = enemy_states.MOVERIGHT
		3:
			current_states = enemy_states.MOVEUP
		4:
			current_states = enemy_states.MOVEDOWN

func move_down(delta):
	@warning_ignore("standalone_expression", "standalone_expression", "standalone_expression", "standalone_expression")
	Vector2.DOWN # pour que notre ennemie bouge sans le contrôler
	velocity.y += speed * delta  # bouge sur l'axe vertical Y et multipler par delta pour contrôler la vitesse de notre ennemie
	velocity.y = clamp(-speed, 15 , speed)  # pour mettre une limite à la vitesse pour qu'il ne dépasse pas 
	velocity.x = 0 # sinon l'ennemi reste se déplace d'une sorte diagonale bizarre.
	$anim.play("move_down")
func move_up(delta):
	@warning_ignore("standalone_expression")
	Vector2.UP 
	velocity.y -= speed * delta  
	velocity.y = clamp(speed, 15 , -25)  
	velocity.x = 0
	$anim.play("move_up")

func move_left(delta):
	@warning_ignore("standalone_expression")
	Vector2.LEFT 
	velocity.x -= speed * delta  
	velocity.x = clamp(speed, 15 , -25)  
	velocity.y = 0
	$anim.play("move_left")

func move_right(delta):
	@warning_ignore("standalone_expression", "standalone_expression", "standalone_expression", "standalone_expression", "standalone_expression", "standalone_expression")
	Vector2.RIGHT 
	velocity.x += speed * delta 
	velocity.x = clamp(-speed, 15 , speed)  
	velocity.y = 0
	$anim.play("move_right")

func dead(): # fonction pour jouer mon animation anim
	dead_animation()
	velocity.x = 0 # comme çà il ne bouge plus au moment oû il meurt 
	velocity.y = 0
	$anim.play("Dead")
	await $anim.animation_finished
	looting() # çà va instancier la pièce là oû se trouve mon ennemi
	queue_free() # pour supprimer notre objet (ennemie) après l'attaque 


func flash(): # fonction pour nous démontre que notre joeur est blessé(changement de coleur)
	$Sprite2D.material.set_shader_parameter("flash_modifier", 1) # donne couleur blanc à mon joeur càd blessé
	await get_tree().create_timer(0.3).timeout # temps écolué apendant la blesure avant qu'il revient à son état normal
	$Sprite2D.material.set_shader_parameter("flash_modifier", 0) # couleur 0 càd la couleur normal de notre joeur après qu'il a revenu à son état normal

func looting(): # permet d'accéder à différents éléments 
	var piece = coin_loot.instantiate() # permet d'instancier donc charger notre piece quand notre ennemi va mourir
	piece.global_position = global_position # permettre de pouvoir établir la position de notre pièce en fonction de la position de notre ennemi
	get_tree().get_root().add_child(piece)
	
func dead_animation():
	var dead = dead_fx.instantiate()
	dead.global_position = global_position
	get_tree().get_root().add_child(dead)
