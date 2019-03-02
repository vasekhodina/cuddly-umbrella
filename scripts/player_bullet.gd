extends Area2D

var velocity = Vector2()
export var speed = 500

func start_at(dir, pos, v):
    rotation = dir
    position = pos
    velocity = v + Vector2(0, -speed).rotated(90)

func _process(delta):
    position = position + velocity * delta

func _on_lifetime_timeout():
    queue_free()
