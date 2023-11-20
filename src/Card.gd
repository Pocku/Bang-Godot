extends Sprite

var moving = false;
var can_grab = false;
var grab_mouse = Vector2();



func point_in_rect(point,rect):
	return point.x>rect.x && point.x<rect.x+rect.w && point.y>rect.y && point.y<rect.y+rect.h;
