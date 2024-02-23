extends saving_manager # çà va hériter les fonctions


# Called when the node enters the scene tree for the first time.
func _ready():
	if player_data.save_key == 0 && !FileAccess.file_exists(save_path):
# c à d qu'on n'a pas appuyé sur la save && s'il n'a pas de fichier "file existe" sans le save
# il passe donc dans notre dossier Open User Data folder
		return 
	else : # on peut dire va charger les données 
		load_data() # on appelle la fonction pour faire un load de données automatiquement 
	if player_data.last_position != null :
		$Player.global_position = player_data.last_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func shop_methode():
	pass
