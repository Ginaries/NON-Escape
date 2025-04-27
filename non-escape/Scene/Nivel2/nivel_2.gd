extends Node2D
var PuertaAbierta=false
@onready var palanca_2: Area2D = $HBoxContainer/SubViewportContainer1/SubViewport/Palanca2
@onready var palanca: Area2D = $HBoxContainer/SubViewportContainer1/SubViewport/Palanca


func _ready() -> void:
	Global.MisionActual=2
	Global.InciarNivel()
	var world =$HBoxContainer/SubViewportContainer1/SubViewport.find_world_2d()
	$HBoxContainer/SubViewportContainer2/SubViewport.world_2d=world

func _process(_delta: float) -> void:
	if Global.LlavesPendiente==0:
		Global.PuertaAbierta=true
		PuertaAbierta=true

	if Global.ESTANVIVOS<=0:
		get_tree().change_scene_to_file("res://Scene/Nivel2/nivel_2.tscn")
	
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_file("res://Scene/Menu/menu.tscn")
