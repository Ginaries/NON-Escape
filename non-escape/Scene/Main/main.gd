extends Node2D

var PuertaAbierta= false

@onready var llave : Area2D = $Llave

func _ready() -> void:
	Global.MisionActual=0
	Global.InciarNivel()
	
func _process(delta: float) -> void:
	if llave==null:
		Global.PuertaAbierta=true
	if Global.ESTANVIVOS<=0:
		get_tree().change_scene_to_file("res://Scene/Main/main.tscn")
	if Input.is_action_just_pressed("Escape"):
		get_tree().change_scene_to_file("res://Scene/Menu/menu.tscn")
