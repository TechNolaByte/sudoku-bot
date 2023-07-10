if(finalState > -1) exit;

var _i = 0;
for(var _y = 0; _y < 3; _y++){
	for(var _x = 0; _x < 3; _x++){
		if(possibleStates[_i] == false){ _i++; continue; }

		var _drawSubX = x+(SubCellSize*_x);
		var _drawSubY = y+(SubCellSize*_y);
				
		if(point_in_rectangle(mouse_x, mouse_y, _drawSubX, _drawSubY, _drawSubX+SubCellSize-1, _drawSubY+SubCellSize-1)){
			
			// Set & ripple
			if(mouse_check_button_pressed(mb_left)){
				with(obj_Controller) save_board();
				set_final(_i);
				final_was_sourced_from_click = true;
				exit;
			}
			
			// manual correction & ripple
			if(mouse_check_button_pressed(mb_right)){
				with(obj_Controller) save_board();
				remove_state(_i);
				exit;
			}
			
			// Preview
			with(obj_Cell){
				if(tileX == other.tileX
				|| tileY == other.tileY
				|| (floor(tileX/3) == floor(other.tileX/3) && floor(tileY/3) == floor(other.tileY/3))
				){
					subcell_hovered = _i;
				}else subcell_hovered_impossible = _i;
			}
		}
	
		_i++;
	}
}
