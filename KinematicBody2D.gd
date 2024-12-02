extends KinematicBody2D
const Newvar2 = preload("res://Enemy/Bat.tscn")

export var acc = 1500
export var fric = 2500
export var maxspeed = 500


onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var swordhitbox = $Position2D/HitBox
onready var hurtbox = $HurtBox
const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn") 

enum{
	MOVE,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO
var stats = PlayerStats

func _ready():
	randomize()
	stats.connect("no_health", self, "fail")
	animation_tree.active = true
	swordhitbox.knockback_vector= Vector2.LEFT
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		
func fail():
	queue_free()
	get_tree().change_scene("res://Failed.tscn")

func move_state(delta):
		var in_vec = Vector2.ZERO
		
		in_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		in_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		in_vec = in_vec.normalized()
		
		if in_vec != Vector2.ZERO:
			#print(newvar2)
			#animation_player.play("RunDown")
			#velocity += in_vec * acc * delta
			#velocity = velocity.clamped(500 * delta)
			swordhitbox.knockback_vector = in_vec
			animation_tree.set("parameters/Idle/blend_position", in_vec)
			animation_tree.set("parameters/Run/blend_position", in_vec)
			animation_tree.set("parameters/Attack/blend_position", in_vec)
			animation_state.travel("Run")
			velocity = velocity.move_toward(in_vec * 500, acc * delta)
		else:
			animation_state.travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, fric * delta)
			
		velocity = move_and_slide(velocity)
		
		if Input.is_action_just_pressed("attack"):
			state = ATTACK
		
		
func attack_state(delta):
		velocity = Vector2.ZERO
		animation_state.travel("Attack")
		
func attack_animation_finished():
	state = MOVE


func _on_HurtBox_area_entered(area):
	stats.health -= 1
	hurtbox.start_invincibility(0.5)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)


#func _on_World_set_health_player():
#	stats.health = 10
