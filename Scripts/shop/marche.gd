extends StaticBody2D

func _ready():
	$shopmenu.visible = false

func _process(delta):
	if $shopmenu.item1owned == true:
		$CleSecret.visible = true
	if $shopmenu.item2owned == true:
		$CleSecret.visible = true
	if $shopmenu.item3owned == true:
		$CleSecret.visible = true

func _on_area_2d_body_entered(body):
	if body.has_method("shop_methode"):
		$shopmenu.visible = true

func _on_area_2d_body_exited(body):
	$shopmenu.visible = false
