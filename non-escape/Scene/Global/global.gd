extends Node

var MisionActual=0
var LlaveEncontrada=0
var TiempoRestante=0
var LlavesPendiente=0
var PuertaAbierta=false
var ESTANVIVOS=2

func InciarNivel():
	if MisionActual ==0:
		ESTANVIVOS=2
		LlavesPendiente=1
		PuertaAbierta=false
	if MisionActual==1:
		ESTANVIVOS=2
		LlavesPendiente=1
		PuertaAbierta=false
	if MisionActual==2:
		ESTANVIVOS=2
		LlavesPendiente=2
		PuertaAbierta=false


func SiguienteNivel():
	match MisionActual:
		0:
			get_tree().change_scene_to_file("res://Scene/Nivel1/nivel_1.tscn")
			MisionActual+=1
		1:
			get_tree().change_scene_to_file("res://Scene/Nivel2/nivel_2.tscn")
			MisionActual+=1
		2:
			get_tree().change_scene_to_file("res://Scene/creditos/control.tscn")
			MisionActual=0
		
