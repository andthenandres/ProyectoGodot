extends CharacterBody2D       
const JUMP = -400
const SPEED = 200
const SPRINT = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Fisicas
func _physics_process(delta: float) -> void:
	#Gravedad
	if(!is_on_floor()):
		velocity += get_gravity() * delta
	#Movimiento horizontal
	if(Input.is_action_pressed("ui_right")):
		velocity.x += SPEED 
	elif(Input.is_action_pressed("ui_left")):
		velocity.x -= SPEED
	#DUDA: Porque es necesario poner el else: RESPUESTA, hay que volver a configurar la velocidad
	else:
		velocity.x = 0
	 #Salto
	if(Input.is_action_just_pressed("ui_up") and !is_on_floor()):
		velocity.y += JUMP
	move_and_slide()
	
# Animaciones
func _process(delta: float) -> void:
	if(velocity.x == 200):
		$AnimatedSprite2D.play("walking")
	elif(velocity.x == -200):
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = true
	if(velocity.y == -400):
		$AnimatedSprite2D.play("taunting")
