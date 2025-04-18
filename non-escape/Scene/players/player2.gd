extends CharacterBody2D

@export var velocidad: float = 300.0
@export var puede_interactuar: bool = false
var enemigos: Array = []
var PuedeEscapar=false
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var detector_interaccion: Area2D = $Detector_Interaccion
@onready var linterna_ver: Area2D = $LinternaVer
@onready var linterna_e_interaccion: Timer = $"Linterna e Interaccion"
@onready var linternaSprite: Sprite2D = $Linterna

func _ready():
	enemigos = get_tree().get_nodes_in_group("enemigos")

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
		linternaSprite.visible=true
		puede_interactuar = true
		linterna_e_interaccion.start(3.0)
	for area in linterna_ver.get_overlapping_areas():
		if area.has_method("MostrarPuerta") and puede_interactuar==true:
			area.MostrarPuerta()

func interactuar():
	if Input.is_action_just_pressed("interaccion2") and puede_interactuar:
		if Global.LlavesPendiente<=0 and puede_interactuar and PuedeEscapar:
			Global.SiguienteNivel()
		for enemigo in enemigos:
			if is_instance_valid(enemigo) and enemigo.has_method("set_target"):
				enemigo.set_target(self)
		
		# Interacción con objetos cercanos
		for area in detector_interaccion.get_overlapping_areas():
			if area.has_method("intentar_interactuar"):
				area.intentar_interactuar(self)


func _on_linterna_e_interaccion_timeout() -> void:
	puede_interactuar=false
	linternaSprite.visible=false
	


func _on_linterna_ver_area_exited(area: Area2D) -> void:
	if area.is_in_group("puerta"):
		area.Alejado()
