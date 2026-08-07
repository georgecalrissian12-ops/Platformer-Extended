extends CharacterBody2D

const SPEED: int = 130
const JUMP_VELOCITY: int = -360
var respawn_position: Vector2
var dead: bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var score_label: Label = $Score
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var score: int = 0

func _ready() -> void:
	respawn_position = global_position

func _physics_process(delta: float) -> void:
	#Handle Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#Handle Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Get input direction
	var direction = Input.get_axis("move left", "move right")
	
	#Apply Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	#print(animated_sprite_2d.animation)
	#Play animations
	if not dead:
		if is_on_floor():
			if direction == 0:
				animated_sprite_2d.play("Idle")
			else: 
				animated_sprite_2d.play("Run")
		else:
			animated_sprite_2d.play("Jump")
	
	#Flip the sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	
	move_and_slide()


func pickup_coin():
	score += 1
	score_label.text = "Score: " + str(score)
	
func die():
	dead = true
	animated_sprite_2d.play("Death")
