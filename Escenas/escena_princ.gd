extends CharacterBody2D       
const JUMP = -400
const SPEED = 200
const SPRINT = 400
var areaMuerte = false
var baile = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Fisicas
func _physics_process(delta: float) -> void:
	#Gravedad
	if(!is_on_floor()):
		velocity += get_gravity() * delta
	#Movimiento horizontal
	if(areaMuerte):
		velocity = Vector2(0,0)
	elif(Input.is_action_pressed("ui_right")):
		velocity.x += SPEED * delta
	elif(Input.is_action_pressed("ui_left")):
		velocity.x -= SPEED * delta
	elif(Input.is_action_just_pressed("Tab")):
		baile = true
	#DUDA: Porque es necesario poner el else: RESPUESTA, hay que volver a configurar la velocidad
	
	 #Salto
	if(Input.is_action_just_pressed("ui_up") and is_on_floor()):
		velocity.y += JUMP
	move_and_slide()
	
# Animaciones
func _process(delta: float) -> void:
	if(velocity.x == 0):
		$AnimatedSprite2D.play("idle")
	elif(velocity.x == -SPEED):
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = true
	elif(velocity.x == SPEED):
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = false
	elif(baile):
		$AnimatedSprite2D.play("taunting")
	if(velocity.y == -400):
		$AnimatedSprite2D.play("jumping")
	if(areaMuerte):
		$AnimatedSprite2D.play("dying")
#RockFall
func _rockfall(delta: float) -> void:
	if not is_on_floor() and Input.is_action_pressed("Shift"):
		velocity += get_gravity() * delta * 2
	elif(is_on_floor() and Input.is_action_just_released("Shift")):
			velocity += get_gravity() * delta	
			

func _on_area_muerte_body_entered(body: Node2D) -> void:	
	areaMuerte = true
		


func _on_area_muerte_body_exited(body: Node2D) -> void:
	areaMuerte = false
