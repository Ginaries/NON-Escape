extends CharacterBody2D

@export var velocidad: float = 500.0
@export var puede_interactuar: bool = false
var enemigo: Node = null

@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var detector_interaccion: Area2D = $Detector_Interaccion

func _ready():
	enemigo = get_tree().get_root().get_node("Main/Enemigo")

func _physics_process(delta: float) -> void:
	var input_direction = Vector2(
		Input.get_axis("izq2", "der2"),
		Input.get_axis("up2", "down2")
	)
	
	if input_direction != Vector2.ZERO:
		velocity = input_direction.normalized() * velocidad
		move_and_slide()
		
		if not audio_stream_player.playing:
			audio_stream_player.play()
	else:
		audio_stream_player.stop()
		velocity = Vector2.ZERO

	linterna()
	interactuar()

func linterna():
	if Input.is_action_just_pressed("linterna2"):
		puede_interactuar = true
		await get_tree().create_timer(5).timeout
		puede_interactuar = false

func interactuar():
	if Input.is_action_just_pressed("interaccion2") and puede_interactuar:
		if enemigo:
			enemigo.set_target(self)

		for area in detector_interaccion.get_overlapping_areas():
			if area.has_method("intentar_interactuar"):
				area.intentar_interactuar(self)
