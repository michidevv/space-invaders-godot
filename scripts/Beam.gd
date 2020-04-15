extends KinematicBody2D

export var speed = 280

func _physics_process(delta):
	move_and_collide(Vector2(0, -1 * speed * delta))

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func destroy():
	queue_free()
