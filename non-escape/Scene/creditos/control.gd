extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	# Llamás a una función que maneja la espera
	wait_for_animation()

# Función asíncrona que espera la animación y cambia la escena
func wait_for_animation() -> void:
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://Scene/Menu/menu.tscn")
	
