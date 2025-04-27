extends StaticBody2D
@onready var ocultar: Timer = $Ocultar
@onready var icon: Sprite2D = $Icon
var jugador_cercano: Node = null


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		jugador_cercano=body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		jugador_cercano=null


func _on_ocultar_timeout() -> void:
	icon.visible=false


func Mostrar():
	icon.visible=true
	ocultar.start(1.0)

func Alejado():
	ocultar.stop()
	icon.visible=false
