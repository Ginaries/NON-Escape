extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var grito: AudioStreamPlayer2D = $Grito

@export var velocidad: float = 300.0  # Cambiado a float para mayor precisión
@export var puede_interactuar: bool = false
var enemigos: Array = []
@onready var linternaSprite: Sprite2D = $Linterna
var PuedeEscapar=false
@onready var detector_interaccion: Area2D = $Detector_Interaccion
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var linterna_ver: Area2D = $LinternaVer
@onready var linterna_e_interaccion: Timer = $"Linterna e Interaccion"
var vivo=true

func _ready():
	enemigos = get_tree().get_nodes_in_group("enemigos")
	

func _physics_process(_delta: float) -> void:
	var input_direction = Vector2(
		Input.get_axis("izq", "der"),
		Input.get_axis("up", "down")
	)

	if input_direction != Vector2.ZERO and vivo:
		velocity = input_direction.normalized() * velocidad
		move_and_slide()

		# Animación de caminar
		animated_sprite_2d.play("walk")

		# Flip horizontal si va a la izquierda
		if input_direction.x < 0:
			animated_sprite_2d.flip_h = true
		elif input_direction.x > 0:
			animated_sprite_2d.flip_h = false

		if not audio_stream_player.playing:
			audio_stream_player.play()
	else:
		audio_stream_player.stop()
		velocity = Vector2.ZERO
		animated_sprite_2d.play("idle")  # Animación en idle cuando no se mueve

	# Resto de funciones
	linterna()
	interactuar()


func linterna():
	if Input.is_action_just_pressed("linterna") and vivo==true:
		linternaSprite.visible=true
		puede_interactuar = true
		linterna_e_interaccion.start(3.0)
		for enemigo in enemigos:
			if is_instance_valid(enemigo) and enemigo.has_method("set_target"):
				enemigo.set_target(self)
	for area in linterna_ver.get_overlapping_areas():
		if area.has_method("Mostrar") and puede_interactuar==true:
			area.Mostrar()
	for body in linterna_ver.get_overlapping_bodies():
		if body.has_method("Mostrar") and puede_interactuar==true:
			body.Mostrar()

func interactuar():
	if Input.is_action_just_pressed("interaccion") and puede_interactuar:
		if puede_interactuar and Global.PuertaAbierta == true and PuedeEscapar == true:
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
	if area.has_method("Alejado"):
		area.Alejado()

func Morir():
	if vivo:
		vivo = false
		Global.ESTANVIVOS-=1
		grito.play()
	for enemigo in enemigos:
		if is_instance_valid(enemigo) and enemigo.has_method("on_player_died"):
			enemigo.on_player_died(self)

func Revivir():
	print("revivi puto1"+name)
	vivo=true
	if Global.ESTANVIVOS<2:
		Global.ESTANVIVOS+=1

func esta_vivo() -> bool:
	return vivo


func _on_detector_interaccion_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.Revivir()
