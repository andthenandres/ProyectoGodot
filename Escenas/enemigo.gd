extends CharacterBody2D
const WALKING = 75
var velocidad_actual = WALKING

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _physics_process(delta: float) -> void:
	#RayCast2D
	if $RayCastDerecha2D.is_colliding():
		velocidad_actual = -WALKING
		
	if $RayCastIzquierda2D.is_colliding():
		velocidad_actual = WALKING
	#if not $RayCastSueloIzquierda2D.is_colliding():
	#	velocidad_actual = WALKING
	
	#if not $RayCastSueloDerecha2D.is_colliding():
	#	velocidad_actual = -WALKING
	velocity.x = velocidad_actual
	move_and_slide()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
