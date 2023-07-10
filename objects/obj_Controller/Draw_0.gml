draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

for(var _x = 0; _x < 3; _x++){
	for(var _y = 0; _y < 3; _y++){
		var _drawX = 5+(MetaCellSize*_x);
		var _drawY = 5+(MetaCellSize*_y);

		var _w = 3;
		draw_line_width(_drawX, _drawY, _drawX, _drawY+MetaCellSize-1, _w);
		draw_line_width(_drawX+MetaCellSize-1, _drawY, _drawX+MetaCellSize-1, _drawY+MetaCellSize-1, _w);
		draw_line_width(_drawX, _drawY, _drawX+MetaCellSize-1, _drawY, _w);
		draw_line_width(_drawX, _drawY+MetaCellSize-1, _drawX+MetaCellSize-1, _drawY+MetaCellSize-1, _w);
	}
}

with(obj_Cell) draw();

