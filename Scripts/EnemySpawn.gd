extends Node2D

@export var enemy_scene: PackedScene
var enemy_instance = null
#spawmの候補(多分markerで管理した方が後で楽)
var spawn_positions = [-197, -133, -69, -5, 59, 123, 187, 251 ,315, 379, 443]

func _ready():
	# 敵のPackedSceneをロードします。
	var enemy_scene = load("res://Scenes/enemy_fish.tscn")
	# 敵のインスタンスを作成します。
	enemy_instance = enemy_scene.instantiate()

func _process(delta):
	if should_spawn_enemy():
		spawn_enemy()

func should_spawn_enemy():
	# ここでは敵を生成する条件を定義します。例えば、一定時間ごとや一定のスコアに達したときなどです。
	# この関数がtrueを返すときに敵が生成されます。具体的な条件はゲームの要件によります。
	return true

func spawn_enemy():
	# ランダムなスポーン位置を選択します。
	var spawn_x = spawn_positions[randi() % spawn_positions.size()]
	var spawn_y = 1000

	# 敵をスポーン位置に配置します。
	enemy_instance.position = Vector2(spawn_x, spawn_y)
	
	# 敵をシーンに追加します。
	add_child(enemy_instance)

func _on_EnemyTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

