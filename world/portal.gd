extends Area2D





func _on_Area_body_entered(body):
	get_tree().change_scene("res://2ndlevel.tscn")
