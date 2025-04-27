extends Area2D

var jugador_cercano: Node = null
@onready var icon: Sprite2D = $Icon
@onready var ocultar: Timer = $ocultar



func intentar_interactuar(jugador):
	if jugador == jugador_cercano:
		print(jugador.name + " agarró la llave")
		Global.LlavesPendiente -= 1
		queue_free()

func Mostrar():
	icon.visible=true
	ocultar.start(1.0)

func Alejado():
	ocultar.stop()
	icon.visible=false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		jugador_cercano=body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		jugador_cercano=null


func _on_ocultar_timeout() -> void:
	icon.visible=false
