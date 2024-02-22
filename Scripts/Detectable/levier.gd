extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.name == "Sword":
		player_data.porte_ouverte = true
		$anim.play("opening")
		await $anim.animation_finished
		$anim.play("opened")
		
