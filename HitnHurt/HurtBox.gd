extends Area2D

#export(bool) var show_hit = true #to use this in grass to not show this effect
const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible
onready var timer = $Timer
onready var collisionshape = $CollisionShape2D

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
	
func start_invincibility(duration):
	self.invincible = true
	timer.start((duration))

func create_hit_effect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position


func _on_Timer_timeout():
	self.invincible = false


func _on_HurtBox_invincibility_ended():
	collisionshape.disabled = false


func _on_HurtBox_invincibility_started():
	collisionshape.set_deferred("disabled", true)

