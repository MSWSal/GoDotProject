extends Node2D
var stats = PlayerStats



func _on_replay_pressed():
	stats.health = 10
	get_tree().change_scene("res://Node2D.tscn")


func _on_menu_pressed():
	get_tree().change_scene("res://MainMenu.tscn")
