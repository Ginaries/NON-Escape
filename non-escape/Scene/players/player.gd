extends CharacterBody2D

@export var velocidad: float = 300.0  # Cambiado a float para mayor precisión
@export var puede_interactuar: bool = false
var enemigo: Node = null

@onready var detector_interaccion: Area2D = $Detector_Interaccion
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

signal interactuando

func _ready():
	enemigo = get_tree().get_root().get_node_or_null("Main/Enemigo")

func _physics_process(delta: float) -> void:
	var input_direction = Vector2(
		Input.get_axis("izq", "der"),  # Método más eficiente para obtener inputs
		Input.get_axis("up", "down")
	)
	
	# Aplicamos movimiento solo si hay input
	if input_direction != Vector2.ZERO:
		velocity = input_direction.normalized() * velocidad
		move_and_slide()  # No multiplicamos por delta aquí (Godot lo maneja internamente)
		
		if not audio_stream_player.playing:
			audio_stream_player.play()
	else:
		audio_stream_player.stop()
		velocity = Vector2.ZERO  # Aseguramos que se detenga completamente

	# Resto de funciones
	linterna()
	interactuar()

func linterna():
	if Input.is_action_just_pressed("linterna"):
		puede_interactuar = true
		await get_tree().create_timer(5).timeout
		puede_interactuar = false

func interactuar():
	if Input.is_action_just_pressed("interaccion") and puede_interactuar:
		emit_signal("interactuando")
		if enemigo:
			enemigo.set_target(self)

		for area in detector_interaccion.get_overlapping_areas():
			if area.has_method("intentar_interactuar"):
				area.intentar_interactuar(self)
