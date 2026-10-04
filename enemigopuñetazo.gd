extends StaticBody2D

func _physics_process(delta: float) -> void:
	# 1. El enemigo lee los RayCasts continuamente cada frame
	if $RayCastDerecha2D.is_colliding():
		_atacar(false) # Voltear = falso (Ataca a la derecha)
	elif $RayCastIzquierda2D.is_colliding():
		_atacar(true)  # Voltear = verdadero (Ataca a la izquierda)
	else:
		# 2. Si te alejas del alcance de ambos, vuelve al reposo
		$AnimatedSprite2D.play("idle")
		$AreaPunetazo/CollisionShape2D.set_deferred("disabled", true)

func _atacar(voltear_izquierda: bool) -> void:
	# 3. Se gira instantáneamente hacia donde estés
	$AnimatedSprite2D.flip_h = voltear_izquierda
	
	# Mueve la caja de daño al lado correspondiente
	if voltear_izquierda:
		$AreaPunetazo.position.x = -60
	else:
		$AreaPunetazo.position.x = 60
		
	# Mantiene activa la animación de golpear sin interrupciones
	$AnimatedSprite2D.play("punching")

func _process(delta: float) -> void:
	# 4. Sincronización del daño letal
	if $AnimatedSprite2D.animation == "punching":
		# Solo se enciende la colisión en los frames de máximo alcance. 
		# (Sustituye el 4 y el 7 por los números exactos de tu animación)
		if $AnimatedSprite2D.frame >= 4 and $AnimatedSprite2D.frame <= 7:
			$AreaPunetazo/CollisionShape2D.set_deferred("disabled", false)
		else:
			$AreaPunetazo/CollisionShape2D.set_deferred("disabled", true)
	else:
		# Si está en "idle" u otra animación, el puño siempre es inofensivo
		$AreaPunetazo/CollisionShape2D.set_deferred("disabled", true)
