extends Area2D

@onready var timer: Timer = $Timer
var player: CharacterBody2D

func _on_body_entered(body: Node2D) -> void:
	
	
	player = body
	#body.get_node("CollisionShape2D").set_deferred("disabled", true)
	if not body.dead:
		Engine.time_scale = 0.5
		body.die()
		timer.start()



func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	
	player.global_position = player.respawn_position
	#player.get_node("CollisionShape2D").set_deferred("disabled", false)
	player.dead = false
	player.velocity = Vector2.ZERO
	
