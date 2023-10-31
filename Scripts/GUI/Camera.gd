extends Camera2D

@export var tilemap: TileMap # comme çà je peux accéder aux différents éléments de mon tielmap sur Ground
@export var player: CharacterBody2D # pour shopper la position de personnage

# Called when the node enters the scene tree for the first time.
func _ready():
	var map_rect = tilemap.get_used_rect() # carte rectangle 
	var tile_size = tilemap.cell_quadrant_size
	var world_size = map_rect.size * tile_size
	
	limit_right = world_size.x  # j'appel les paramètres limites
	limit_bottom = world_size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = player.position  # commme çà la caméra suit mon personnage 
