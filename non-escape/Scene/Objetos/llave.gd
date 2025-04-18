extends Area2D

var jugador_cercano: Node = null



func intentar_interactuar(jugador):
	if jugador == jugador_cercano:
		print(jugador.name + " agarró la llave")
		queue_free()



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		jugador_cercano=body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		jugador_cercano=null
