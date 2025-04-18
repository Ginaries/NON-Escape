extends Node

var MisionActual=0
var LlaveEncontrada=0
var TiempoRestante=0
var LlavesPendiente=0

func InciarNivel():
	if MisionActual ==0:
		LlavesPendiente=1
		

func NuevoJuego():
	MisionActual=0

func SiguienteNivel():
	match MisionActual:
		0:
			get_tree().change_scene_to_file("res://Scene/Nivel1/nivel_1.tscn")
			MisionActual+=1
		
