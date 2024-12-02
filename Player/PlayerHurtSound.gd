extends AudioStreamPlayer

# Declare member variables here. Examples:

func _ready():
	connect("finished",self,"queue_free")
