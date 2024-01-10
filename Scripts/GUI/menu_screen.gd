extends Node2D

var selection_menu = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	changer_menu()
	$anim.play("Active")
	


func changer_menu():
	$Play/ColorRect.color = Color.GRAY
	$quit/ColorRect.color = Color.GRAY
	match selection_menu:
		0:
			$Play/ColorRect.color = Color.LIGHT_SALMON # changer la couleur de button quand on séléctionne
		1:
			$quit/ColorRect.color = Color.LIGHT_SALMON

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func anim_bouncing():
	$anim.play("bouncing")

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		selection_menu = (selection_menu + 1) % 2;
		changer_menu()
	elif Input.is_action_just_pressed("ui_up"):
		if selection_menu > 0 :
			selection_menu = selection_menu - 1
		else : 
			selection_menu = 1 
		changer_menu()
	elif Input.is_action_just_pressed("ui_accept"):
		match selection_menu:
			0:
				_on_play_pressed()
			1:
				_on_quit_pressed()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn") # quand on appuyera sue le button Jouer, on pourra allez sur notre scène main level


func _on_quit_pressed():
	get_tree().quit()
