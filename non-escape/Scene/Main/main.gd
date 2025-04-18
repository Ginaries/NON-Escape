extends Node2D

var PuertaAbierta= false

@onready var llave : Area2D = $Llave

func _ready() -> void:
	Global.InciarNivel()
	
func _process(delta: float) -> void:
	if llave==null:
		PuertaAbierta=true
