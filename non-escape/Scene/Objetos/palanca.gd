extends Area2D

var jugador_cercano: Node = null
var progreso := 0.0
var completo := 1000.0
var cargando := false
@onready var ocultar: Timer = $Ocultar

@onready var progress_bar: ProgressBar = $AnimatedSprite2D/ProgressBar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _process(delta: float) -> void:
	if cargando and jugador_cercano and jugador_cercano.esta_vivo():
		progreso += delta * 50  # velocidad de carga (ajustable)
		if progreso >= completo:
			progreso = completo
			activar_palanca()
	else:
		# Opcional: que se vacíe si deja de interactuar
		if progreso > 0:
			progreso -= delta * 30  # velocidad de descarga

	progress_bar.value = progreso


func intentar_interactuar(jugador):
	if jugador == jugador_cercano:
		cargando = true


func dejar_de_interactuar():
	cargando = false


func activar_palanca():
	print("¡Palanca activada!")
	Global.LlavesPendiente-=1
	set_process(false)
	$AnimatedSprite2D.play("Open")  # si tenés una animación

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		jugador_cercano = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		jugador_cercano = null
		dejar_de_interactuar()

func Mostrar():
	animated_sprite_2d.visible=true
	ocultar.start(1.0)

func Alejado():
	ocultar.stop()
	animated_sprite_2d.visible=false
