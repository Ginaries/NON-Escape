extends Area2D

@export var Velocidad: int = 500
var PuedoInteractuar = false
var enemigo: Node = null
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready():
	enemigo = get_tree().get_root().get_node("Main/Enemigo") # Ajustá el path

func _process(delta: float) -> void:
	# Movimiento
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("der2"):
		velocity.x += 1
	if Input.is_action_pressed("izq2"):
		velocity.x -= 1
	if Input.is_action_pressed("down2"):
		velocity.y += 1
	if Input.is_action_pressed("up2"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * Velocidad
		position += velocity * delta
		if not audio_stream_player_2d.playing:
			audio_stream_player_2d.play()
	else:
		audio_stream_player_2d.stop()
	# Interacciones
	Linterna()
	Interactuar()

func Linterna():
	if Input.is_action_just_pressed("linterna2"):
		PuedoInteractuar = true
		await get_tree().create_timer(5).timeout
		PuedoInteractuar = false

func Interactuar():
	if Input.is_action_just_pressed("interaccion2") and PuedoInteractuar:
		if enemigo:
			enemigo.set_target(self)
