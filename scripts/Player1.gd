extends KinematicBody2D

export (int) var SPEED
export (float) var ROTATION_SPEED
var screensize
var velocity = Vector2()


func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    screensize = get_viewport_rect().size

func _process(delta):
    velocity = Vector2()
    var rotation_dir = 0
    if Input.is_action_pressed("p1_right"):
        rotation_dir += 1
    if Input.is_action_pressed("p1_left"):
        rotation_dir -= 1
    if Input.is_action_pressed("p1_down"):
        velocity = Vector2(-SPEED, 0).rotated(rotation)
    if Input.is_action_pressed("p1_up"):
        velocity = Vector2(SPEED, 0).rotated(rotation)
    rotation += rotation_dir * ROTATION_SPEED * delta
    move_and_slide(velocity)
