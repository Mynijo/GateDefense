extends ViewportContainer

func can_drop_data(position, data):
	return true
func drop_data(position, data):
	data.rect_position = position