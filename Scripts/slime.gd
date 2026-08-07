extends Node2D


const SPEED: int = 50

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight


var awake: bool = false
var direction: int

func _ready() -> void:
	animated_sprite_2d.play("Asleep")
	
	
func _physics_process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	elif ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
		
	if awake:
		animated_sprite_2d.play("Patrol")
	
	position.x += direction * SPEED * delta



func _on_detection_area_body_entered(_body: Node2D) -> void:
	if not awake:
		animated_sprite_2d.play("Awaken")
		await animated_sprite_2d.animation_finished
		awake = true
		direction = 1
		print("Slime Awoken")
