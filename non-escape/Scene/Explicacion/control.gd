extends Control
@onready var movimiento: Label = $Movimiento
@onready var acciones: Label = $Acciones

var Pantallas=2
var PantallaActual=1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interaccion2"):
		if PantallaActual==2:
			get_tree().change_scene_to_file("res://Scene/Main/main.tscn")
		if PantallaActual==1:
			movimiento.visible=false
			acciones.visible=true
			PantallaActual+=1
