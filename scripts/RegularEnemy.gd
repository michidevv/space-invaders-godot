extends Area2D

signal pattern_changed

const MOVE_PATTERNS = {
	"right": Vector2(1, 0),
	"down": Vector2(0, 1),
	"left": Vector2(-1, 0)
}

export var speed = 5

var animation_name
var pattern = "right"

onready var animated_sprite = $AnimatedSprite
onready var timer = $Timer

func init(pos, name):
	position = pos
	animation_name = name

func _ready():
	timer.start()
	if animation_name:
		animated_sprite.animation = animation_name + "1"

func _on_RegularEnemy_body_entered(body):
	if body.name == "Bounds":
		emit_signal("pattern_changed")
	elif body.name == "Beam":
		body.destroy()
		destroy()
		
func destroy():
	animated_sprite.animation = "death"
	yield(get_tree().create_timer(0.3), "timeout")
	queue_free()

func change_pattern():
	timer.paused = true
	yield(get_tree().create_timer(0.5), "timeout")
	position += MOVE_PATTERNS["down"] * speed
	pattern = "left" if pattern == "right" else "right"
	timer.paused = false

func set_animation_frame():
	if animated_sprite.animation == "death":
		return
		
	var postfix = "2" if animated_sprite.animation.ends_with("1") else "1"
	animated_sprite.animation =	animation_name + postfix

func _on_Timer_timeout():
	position += MOVE_PATTERNS[pattern] * speed
	set_animation_frame()
