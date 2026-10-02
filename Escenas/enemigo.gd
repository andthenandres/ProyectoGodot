extends CharacterBody2D

const WALKING = 75
var velocidad_actual = WALKING

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	#gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	#RayCasts hor
	if $RayCastDerecha2D.is_colliding() and velocidad_actual == WALKING:
		_girar_izquierda()
	elif $RayCastIzquierda2D.is_colliding() and velocidad_actual == -WALKING:
		_girar_derecha()

	# RayCasts ver
	if is_on_floor():
		if not $RayCastSueloDerecha2D.is_colliding() and velocidad_actual == WALKING:
			_girar_izquierda()
		elif not $RayCastSueloIzquierda2D.is_colliding() and velocidad_actual == -WALKING:
			_girar_derecha()

	velocity.x = velocidad_actual
	move_and_slide()

func _process(delta: float) -> void:
	if(velocity.x > 0):
		_girar_derecha()
	else:
		_girar_izquierda()

#girar el sprite
func _girar_izquierda():
	velocidad_actual = -WALKING
	$AnimatedSprite2D.play("walking")
	$AnimatedSprite2D.flip_h = true

func _girar_derecha():
	velocidad_actual = WALKING
	$AnimatedSprite2D.play("walking")
	$AnimatedSprite2D.flip_h = false
