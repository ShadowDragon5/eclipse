extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= 5.5*delta
	self_modulate.a -= 0.5 * delta
	if self_modulate.a <= 0:
		self.queue_free()
