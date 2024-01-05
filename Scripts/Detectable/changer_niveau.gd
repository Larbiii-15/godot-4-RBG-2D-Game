extends Node2D

@onready var player_scene = preload("res://Scenes/Player/player.tscn") # créer une instance de notre player pour qu'il apparaît dans la maison

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = player_scene.instantiate()
	player.global_position = $entree.global_position # pour positionner notre player à l'entrée de la maison
	add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sortie_body_entered(body): # fonction qui permet de nous ramèner à la scène principal quand on sort de la maison
	if body.name == "Player" :
		get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn")
