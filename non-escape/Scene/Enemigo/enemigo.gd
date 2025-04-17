extends Area2D

@export var speed := 300.0
@onready var navegador: NavigationAgent2D = $NavigationAgent2D
var target_player: Node2D = null
var forced_target: Node2D = null  # Prioridad 1

@export var detection_radius: float = 400.0  # Rango de detección automática
@export var players: Array[Node2D] = []  # Añadí tus jugadores en el editor

func set_target(player: Node2D) -> void:
	forced_target = player  # Se activa cuando un jugador interactúa o usa linterna
	target_player = player
	navegador.target_position = player.global_position

func _process(delta: float) -> void:
	if forced_target:
		target_player = forced_target
	elif players.size() > 0:
		var nearest = find_nearest_player()
		if nearest:
			target_player = nearest

	if target_player:
		navegador.target_position = target_player.global_position

		if not navegador.is_navigation_finished():
			var next_position = navegador.get_next_path_position()
			var direction = (next_position - global_position).normalized()
			global_position += direction * speed * delta

func find_nearest_player() -> Node2D:
	var nearest_player :Node2D= null
	var min_dist := detection_radius
	for player in players:
		if not is_instance_valid(player): continue
		var dist = global_position.distance_to(player.global_position)
		if dist < min_dist:
			min_dist = dist
			nearest_player = player
	return nearest_player
