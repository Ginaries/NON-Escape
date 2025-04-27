extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ocultar: Timer = $Ocultar


func Mostrar():
	sprite_2d.visible=true
	ocultar.start(1.0)

func Alejado():
	ocultar.stop()
	sprite_2d.visible=false

func _on_ocultar_timeout() -> void:
	sprite_2d.visible=false

func CambioDeEscena():
	if Global.PuertaAbierta==true:
		Global.SiguienteNivel()



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.PuedeEscapar=true



func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.PuedeEscapar=false
