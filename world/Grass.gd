extends Node2D

const GrassEffect = preload("res://Effects/GrassEffect.tscn")

func create_grass_effect():
		var grassEffect = GrassEffect.instance()  #u cannot add GrassEffect scene, only an instance of it
		#var world = get_tree().current_scene
		get_parent().add_child(grassEffect)
		grassEffect.global_position = global_position
		


func _on_HurtBox_area_entered(area):
		create_grass_effect()
		queue_free()
