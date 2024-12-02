extends Area2D

var player = null 

func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	player = body
#	if Input.is_action_just_pressed("accept"):
#		get_tree().change_scene("res://3rdLevel.tscn")
	print("player entered")


func _on_PlayerDetectionZone_body_exited(body):
	player = null
	print("player exited")
