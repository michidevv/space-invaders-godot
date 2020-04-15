extends KinematicBody2D

var Beam = preload("res://scenes/Beam.tscn")

export var speed = 120

onready var muzzle = $Position2D

var velocity = Vector2()

func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_just_pressed("ui_select"):
		shoot()
		
	move_and_collide(speed * velocity * delta)

func shoot():
	var beam = Beam.instance()
	beam.position = muzzle.global_position
	get_parent().add_child(beam)
