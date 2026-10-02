extends CharacterBody2D       
const JUMP = -400
const WALKING = 75
const SPRINT = 225
var areaMuerte = false
var baile = false
var velocidad_actual = WALKING

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Fisicas
func _physics_process(delta: float) -> void:
	#AreaMuerte
	if(areaMuerte):
		#puedo igualar las 2 vel a 0 o poner gravedad y poner a 0 la hor
		if not is_on_floor():
			velocity += get_gravity() * delta
		velocity.x = 0
		move_and_slide()
		return
	
	#Gravedad
	if(!is_on_floor()):
		velocity = velocity + get_gravity() * delta
	#Salto
	if(Input.is_action_just_pressed("ui_up") and is_on_floor()):
		velocity.y = JUMP
	if(Input.is_action_just_pressed("ui_up") and not is_on_floor()):
		velocity.y = JUMP
	#sprint	
	elif(Input.is_action_pressed("Shift") and Input.is_action_pressed("ui_right")):
		velocity.x = SPRINT	
	elif(Input.is_action_pressed("Shift") and Input.is_action_pressed("ui_left")):
		velocity.x = -SPRINT	
	#caminar
	#if(areaMuerte):
		#velocity = Vector2(0,0)
	elif(Input.is_action_pressed("ui_right")):
		velocity.x = WALKING 
	elif(Input.is_action_pressed("ui_left")):
		velocity.x = -WALKING
	#idle	
	else:
		velocity.x = 0
	if(Input.is_action_just_pressed("Tab")):
		baile = true
	#DUDA: Porque es necesario poner el else: RESPUESTA, hay que volver a configurar la velocidad
	 
	move_and_slide()
	
# Animaciones
func _process(delta: float) -> void:
	#AreaMuerte
	if(areaMuerte):
		$AnimatedSprite2D.play("dying")
		return
	#Salto
	if(velocity.y < 0):
		$AnimatedSprite2D.play("jumping")
	#sprint
	elif(velocity.x == SPRINT):
		$AnimatedSprite2D.play("sprinting")
		$AnimatedSprite2D.flip_h = false
	elif(velocity.x == -SPRINT):
		$AnimatedSprite2D.play("sprinting")
		$AnimatedSprite2D.flip_h = true
	#caminar
	elif(velocity.x == -WALKING):
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = true
	elif(velocity.x == WALKING):
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = false
	#Baile
	elif(baile):
		$AnimatedSprite2D.play("taunting")
	#idle
	else:
		$AnimatedSprite2D.play("idle")
#RockFall
func _rockfall(delta: float) -> void:
	if not is_on_floor() and Input.is_action_pressed("Mayus"):
		velocity += get_gravity() * delta * 2
	elif(is_on_floor() and Input.is_action_just_released("Mayus")):
			velocity += get_gravity() * delta	
			

#la palmas
func _on_area_muerte_body_entered(body: Node2D) -> void:	
	if not areaMuerte:
		areaMuerte = true
		morir()
		
		
func morir() -> void:
	# Se espera para que 
	await $AnimatedSprite2D.animation_finished

	#el juego se cierra (acordarse de quitar el loop en la animacion)
	get_tree().quit()	
	#con esto el juego se reinicia
	#get_tree().reload_current_scene()	
