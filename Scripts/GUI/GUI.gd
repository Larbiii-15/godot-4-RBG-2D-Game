extends CanvasLayer

const HEART_ROW_SIZE = 8  # délilmite le nombre de coeur que l'on peut avoir sur notre axe horizontal
const HEART_OFFSET = 16   # le nombre de pixels qu'il y aura pour espacer le nombre de coeur

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in player_data.health: # s'occupe d'afficher le nombre de vie quand on lance le jeu
		var new_heart = Sprite2D.new()
		new_heart.texture = $player_heart.texture # comme çà à chaque fois il va copie l'image de coeur qui se trouve dans player_heart
		new_heart.hframes = $player_heart.hframes
		$player_heart.add_child(new_heart)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$nombre_piece.text = var_to_str(player_data.coin) 

	for heart in $player_heart.get_children():
		var index = heart.get_index()
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x,y)
		
		var last_heart = floor(player_data.health)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (player_data.health - last_heart) * 4
		if index < last_heart:
			heart.frame = 4 
	
