extends Area2D

@export var Velocidad:int=500
var PuedoInteractuar=false



func _process(delta: float) -> void:
	#-------Movimiento-----------
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * Velocidad
	position += velocity * delta

func Linterna():
	if Input.is_action_just_pressed("linterna"):
		PuedoInteractuar=true
		get_tree().create_timer(5).timeout
		PuedoInteractuar=false

func Interactuar():
	if Input.is_action_just_pressed("interaccion") and PuedoInteractuar==true:
		pass
