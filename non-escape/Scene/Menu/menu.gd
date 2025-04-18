extends Node2D
@onready var color_rect_2: ColorRect = $ColorRect2
var tween: Tween

func _ready():
	# Configura el overlay (debe cubrir toda la pantalla)
	color_rect_2.color = Color(0, 0, 0, 0)  # Inicialmente transparente
	color_rect_2.size = get_viewport_rect().size

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		start_transition()

func start_transition():
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(color_rect_2, "color:a", 1.0, 1.0)
	
	# Efecto de temblor
	var shake_strength = 5.0
	for i in range(10):
		tween.parallel().tween_property(self, "position:x", randf_range(-shake_strength, shake_strength), 0.05)
		tween.parallel().tween_property(self, "position:y", randf_range(-shake_strength, shake_strength), 0.05)
	
	tween.tween_callback(func():
		get_tree().change_scene_to_file("res://Scene/Main/main.tscn")
	)
