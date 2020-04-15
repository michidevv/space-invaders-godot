extends Node2D

func _draw():
	var viewport = get_viewport_rect().size
	var x = max(1, randi() % int(viewport.x))
	var y = max(1, randi() % int(viewport.y))
	draw_circle(Vector2(x, y), randf(), Color(1.0, 1.0, 1.0))
