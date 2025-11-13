extends Node
class_name player_data

static var coin = 0
static var health = 4
static var last_position
static var key = 0 # notre player va collecté les clés
# créer un système qui va me permettre de donner des instructions à respecter
static var save_key = 0
static var porte_ouverte = false
static var score = 0  # Système de score pour suivre la progression du joueur
static var enemies_defeated = 0  # Compteur d'ennemis vaincus
