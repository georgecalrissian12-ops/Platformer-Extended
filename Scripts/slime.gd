extends Node2D

enum Type {GREEN, PURPLE}



@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_right: RayCast2D = $RayCastRight

@export var type: Type
var awake: bool = false
var direction: int
var speed: int

func set_type(new_type: Type):
	type = new_type
	if type == Type.GREEN:
		speed = 100
	elif type == Type.PURPLE:
		speed = 50
	
func _ready() -> void:
	animated_sprite_2d.play("Asleep")
	if type == Type.GREEN:
		speed = 100
	elif type == Type.PURPLE:
		speed = 50
	
	
func _physics_process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	elif ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
		
	if awake:
		animated_sprite_2d.play("Patrol")
	
	position.x += direction * speed * delta



func _on_detection_area_body_entered(_body: Node2D) -> void:
	if not awake:
		animated_sprite_2d.play("Awaken")
		await animated_sprite_2d.animation_finished
		awake = true
		direction = 1
		print("Slime Awoken")
