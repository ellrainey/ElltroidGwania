extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayerBody/PlayerPlaceholder1.play("Shining")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		$PlayerBody/PlayerPlaceholder1.play("frowning")
	if Input.is_action_pressed("ui_accept"):
		$PlayerBody/PlayerPlaceholder1.play("Shining")
