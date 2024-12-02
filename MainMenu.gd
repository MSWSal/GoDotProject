extends Node2D

var stats = PlayerStats 




func _on_Play_pressed():
	stats.health = 10
	get_tree().change_scene("res://Node2D.tscn")


func _on_Instruction_pressed():
	get_tree().change_scene("res://Instruction.tscn")
