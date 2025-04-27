extends Node2D
@onready var llave: Area2D = $HBoxContainer/SubViewportContainer1/SubViewport/Llave
var PuertaAbierta=false


func _ready() -> void:
	Global.MisionActual=1
	Global.InciarNivel()
	var world =$HBoxContainer/SubViewportContainer1/SubViewport.find_world_2d()
	$HBoxContainer/SubViewportContainer2/SubViewport.world_2d=world

func _process(delta: float) -> void:
	if llave==null:
		Global.PuertaAbierta=true
	if Global.ESTANVIVOS<=0:
		get_tree().change_scene_to_file("res://Scene/Nivel1/nivel_1.tscn")
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_file("res://Scene/Menu/menu.tscn")
