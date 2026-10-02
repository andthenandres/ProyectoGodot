extends Node2D

const VELOCIDAD_ROTACION = 3

func _process(delta: float) -> void:
	
	$NodeBola.rotation += VELOCIDAD_ROTACION * delta



func _on_cuerpo_enemigo_2d_body_entered(body: Node2D) -> void:
	#Cuando toque a trump el script deja de funcionar
	queue_free()
