extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var audio_pasivo: AudioStream
@export var audio_agresivo: AudioStream
@export var speed := 300.0
@export var detection_radius: float = 400.0
@onready var navegador: NavigationAgent2D = $NavigationAgent2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var forced_speed:= 375.0
var target_player: Node2D = null
var forced_target: Node2D = null
var forced_target_timer: float = 0.0
var forced_target_duration: float = 5.0  # segundos
var posicion_inicial: Vector2

func _ready() -> void:
	posicion_inicial = global_position

func _process(delta: float) -> void:
	# Si hay forced_target válido y vivo, y aún dentro del tiempo
	if forced_target and is_instance_valid(forced_target) and forced_target.esta_vivo() and forced_target_timer > 0:
		target_player = forced_target
		forced_target_timer -= delta
	else:
		# Limpiar si ya pasó el tiempo o está muerto
		forced_target = null
		target_player = find_nearest_valid_player()

	if target_player:
		navegador.target_position = target_player.global_position
	else:
		navegador.target_position = posicion_inicial


	# Movimiento
	if not navegador.is_navigation_finished():
		var next_position = navegador.get_next_path_position()
		var direction = (next_position - global_position).normalized()

		var current_speed = forced_speed if target_player == forced_target else speed
		global_position += direction * current_speed * delta

		# Animación de caminar
		if direction.length() > 0:
			if animated_sprite_2d.animation != "walk" or not animated_sprite_2d.is_playing():
				animated_sprite_2d.play("walk")

			# Sonido correcto según estado
			var sonido_deseado = audio_agresivo if target_player == forced_target else audio_pasivo
			if not audio_stream_player_2d.playing or audio_stream_player_2d.stream != sonido_deseado:
				audio_stream_player_2d.stream = sonido_deseado
				audio_stream_player_2d.play()
	else:
		# Animación idle
		if animated_sprite_2d.animation != "idle" or not animated_sprite_2d.is_playing():
			animated_sprite_2d.play("idle")
		
		# Sonido solo se apaga si ya no hay target válido
		if not target_player or navegador.is_navigation_finished():
			if audio_stream_player_2d.playing:
				audio_stream_player_2d.stop()






func find_nearest_valid_player() -> Node2D:
	var nearest: Node2D = null
	var min_dist := detection_radius
	var players = get_tree().get_nodes_in_group("Player")

	for player in players:
		if not is_instance_valid(player): continue
		if not player.esta_vivo(): continue
		var dist = global_position.distance_to(player.global_position)
		if dist < min_dist:
			min_dist = dist
			nearest = player

	return nearest

func set_target(player: Node2D) -> void:
	if is_instance_valid(player) and player.esta_vivo():
		forced_target = player
		forced_target_timer = forced_target_duration
		print("⚠️ Atención: persigo a " + player.name)

# Se llama cuando un jugador muere
func on_player_died(player: Node2D) -> void:
	if player == forced_target:
		forced_target = null
		forced_target_timer = 0.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.has_method("Morir"):
		body.Morir()
