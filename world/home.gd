extends Area2D

onready var coll = $CollisionShape2D
var boss = preload("res://Boss.tscn")

var dead = boss

func _ready():
	dead.connect("dead",self,"do")
	
func do():
	coll.disabled = false


func _on_Area2D_body_entered(body):
	print("enter")
#	coll.disabled = false
#	get_tree().change_scene("res://Node2D.tscn")
