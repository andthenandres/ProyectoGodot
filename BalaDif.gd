extends StaticBody2D

const VELOCIDAD = 400

#Se mueve de forma constante
func _physics_process(delta: float) -> void:
	position.x -= VELOCIDAD * delta

#Si entra en area hace tp al inicio
func _on_area_2d_body_entered(body: Node2D) -> void:
	position.x = 0
