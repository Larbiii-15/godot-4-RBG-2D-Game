extends Node
class_name saving_manager
@onready var player = $Player # pour accéder aux données de mon player
# ici notre chemin d'accés pour sauvegarder notre jeu dans un format lisible json
var save_path = "user://savegame.json"

func save_data(): # sauvegarde les données
	var data = {
		"player"	: player.to_dictionary(), # Conversion des Propriétés d'un Objet en Dictionnaire
	}

# fonction qui construit à l'intérieur de Godot, qui nous permet d'accéder à un document spécifique
	var file = FileAccess.open(save_path , FileAccess.WRITE) 
# Après faire appel à json en l'encapsulant dans une variable
	var json = JSON.new() 
# on le transforme (chiffres) ensuite en chaîne de caractère à l'aide de la fonction stringify créer par Godot
	var json_string = json.stringify(data)
# ensuite on va pouvoir accéder à notre file à l'aide de la fonction store_line créer dans Godot 
# qui va nous permettre de sauvegarder nos lignes
	file.store_line(json_string) # maintenant on'a notre base pour sauvegarder notre jeu 

func load_data(): # lire les données 
	var file = FileAccess.open(save_path , FileAccess.READ)
# On va devoir voir si on'a un document là bas qui s'appelle file, si existe on va devoir faire quelque chose avec.
# donc on va créer un statement

	if file.file_exists(save_path): # on va indiquer à Godot d'aller voir dans notre project open userdata 
# s'il y'a un document qui s'appelle savegame
		file = FileAccess.open(save_path , FileAccess.READ)
		var json = JSON.new() 
# on va faire un parsing c à d qu'on va obtenir les données 
		var data = JSON.parse_string(file.get_as_text())
		player.from_dictionary(data.player) # donc maintenant on a la base pour sauvegarder et pour charger nos données
		
		# comment on déclenche le sauvegarde (on va utiliser une touche "v" pour cà)
func _input(event):
 
	if event.is_action_pressed("ui_save"):
		player_data.save_key += 1
		save_data() # donc aprés qu'on a appuyer sur le button V il va appeler la fonction save_data() qui va sauvegarder notre jeu
		print("Jeu Sauvegarder")
# pour facilité le débogage du jeu 
# maintenat la deuxième event pour la partie load on créant le button "N"
	if event.is_action_pressed("ui_load"):
		load_data()
		print("Jeu Charger")
