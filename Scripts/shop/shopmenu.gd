extends StaticBody2D

var item = 1

var item1price = 250
var item2price = 300
var item3price = 200
var item1owned = false
var item2owned = false
var item3owned = false

# Créer des couleurs personnalisées pour les boutons
var colorOwned = Color(25/255, 120/255, 130/255, 1)  # Couleur pour les objets possédés
var colorUnowned = Color(194/255, 12/255, 53/255, 1)  # Couleur pour les objets non possédés


var price

func _ready():
	$icon.play("hache")
	item = 1

func _physics_process(delta):
	if self.visible == true:
		if item == 1:
			$icon.play("hache")
			$priceLabel.text = "100"
			if player_data.coin >= item1price :
				if item1owned == false:
					$buyButton.modulate = colorOwned
				else:
					$buyButton.modulate = colorUnowned
			else :
				$buyButton.modulate = colorUnowned
		elif item == 2:
			$icon.play("key")
			$priceLabel.text = "250"
			if player_data.coin >= item1price :
				if item1owned == false:
					$buyButton.modulate = colorOwned
				else:
					$buyButton.modulate = colorUnowned
			else :
				$buyButton.modulate = colorUnowned
		elif item == 3:
			$icon.play("pele") 
			$priceLabel.text = "300"
			if player_data.coin >= item1price :
				if item1owned == false:
					$buyButton.modulate = colorOwned
				else:
					$buyButton.modulate = colorUnowned
			else :
				$buyButton.modulate = colorUnowned

func _on_left_button_pressed():
	swipe_item_back()

func _on_right_button_pressed():
	swipe_item_foward()

func _on_buy_button_pressed():
	if item == 1:
		price = item1price
	elif item == 2:
		price = item2price
	elif item == 3:
		price = item3price

	if player_data.coin >= price:
		buy() 

func swipe_item_back():
	if item == 1:
		item = 3
	elif item == 2:
		item = 1
	elif item == 3:
		item = 2
	
func swipe_item_foward():
	if item == 1:
		item = 2
	elif item == 2:
		item = 3
	elif item == 3:
		item = 1

func buy():
	player_data.coin -= price
	if item == 1:
		item1owned = true
	elif item == 2:
		item2owned = true
	elif item == 3:
		item3owned = true
