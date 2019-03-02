extends KinematicBody2D

export (int) var SPEED
export (float) var ROTATION_SPEED
var screensize
var velocity = Vector2()
export (PackedScene) var bullet
onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")


func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    screensize = get_viewport_rect().size
    set_process(true)

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
    if Input.is_action_pressed("p1_shoot") and gun_timer.get_time_left() == 0:
        shoot()
    rotation += rotation_dir * ROTATION_SPEED * delta
    move_and_slide(velocity)

func shoot():
    gun_timer.start()
    var b1 = bullet.instance()
    bullet_container.add_child(b1)
    b1.start_at(rotation, get_node("muzzle_1").get_global_position(), velocity)
    var b2 = bullet.instance()
    bullet_container.add_child(b2)
    b2.start_at(rotation, get_node("muzzle_2").get_global_position(), velocity)
    