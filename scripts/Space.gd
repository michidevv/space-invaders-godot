extends Node2D

var Star = preload("res://scenes/Star.tscn")
var RegularEnemy = preload("res://scenes/RegularEnemy.tscn")

onready var enemy_spawn = $EnemySpawn

var enemy_map = {0: "squid", 1: "crab", 2: "crab", 3: "octopus", 4: "octopus"}

var changed_pattern = false

func _ready():
	randomize()
	generate_stars()
	generate_enemies()

func generate_stars():
	for _i in range(int(rand_range(20, 30))):
		add_child(Star.instance())

func generate_enemies():
	for y in range(4):
		for x in range(10):
			var regular_enemy = RegularEnemy.instance()
			regular_enemy.connect(
				"pattern_changed", 
				self, 
				"_on_RegularEnemy_change_pattern"
			)
			var pos = enemy_spawn.global_position + Vector2(x * 16, y * 16)
			regular_enemy.init(pos, enemy_map[y])
			add_child(regular_enemy)
			
func _on_RegularEnemy_change_pattern():
#	A hack to handle only single emitted event in case when multiple
#	enemies reach screen bounds.
#	Since each is running synchronously, wait for the next frame
#	and run handler only for the first event.
	changed_pattern = false
	yield(get_tree(), "idle_frame")
	if changed_pattern:
		return
		
	for child in get_children():
		if child.has_method("change_pattern"): 
			child.change_pattern()
			
	changed_pattern = true
