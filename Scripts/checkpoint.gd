extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var active: bool = false

func _on_body_entered(body: Node2D) -> void:
	if not active:
		animated_sprite_2d.play("Activate")
		body.respawn_position = global_position
		
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("Active")
		active = true
	
