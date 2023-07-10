// initialized in spawn
// - tileX
// - tileY

finalState = -1;
final_was_sourced_from_click = false;

possibleStates = array_create(9, true);
possibleStateCount = 9;

subcell_hovered = -1;
subcell_hovered_impossible = -1;
draw = function(){
	if(finalState > -1){
		draw_rectangle(x, y, x+CellSize-1, y+CellSize-1, true);
		var _colour = (final_was_sourced_from_click ? c_black : c_green);
		draw_text_transformed_color(x+(CellSize/2), y+(CellSize/2), string(finalState+1), 3, 3, 0, _colour, _colour, _colour, _colour, 1);
		return;
	}
	
	if(subcell_hovered > -1 && possibleStates[subcell_hovered] == true) draw_rectangle_colour(x, y, x+CellSize-1, y+CellSize-1, c_orange, c_orange, c_orange, c_orange, false);
	else draw_rectangle(x, y, x+CellSize-1, y+CellSize-1, true);

	var _i = 0;
	for(var _y = 0; _y < 3; _y++){
		for(var _x = 0; _x < 3; _x++){
			if(possibleStates[_i] == false){ _i++; continue; }
			check_for_all_others_impossible(_i);
			
			var _drawSubX = x+(SubCellSize*_x);
			var _drawSubY = y+(SubCellSize*_y);
			
			var _colour = c_black;
			if(subcell_hovered == _i){
				subcell_hovered = -1; 
				_colour = c_blue;
				draw_rectangle_colour(_drawSubX, _drawSubY, _drawSubX+SubCellSize-1,_drawSubY+SubCellSize-1, c_yellow, c_yellow, c_yellow, c_yellow, false);
			}
			
			if(subcell_hovered_impossible == _i){
				subcell_hovered_impossible = -1; 
				draw_rectangle_colour(_drawSubX, _drawSubY, _drawSubX+SubCellSize-1,_drawSubY+SubCellSize-1, c_red, c_red, c_red, c_red, false);
			}
			
			draw_possible_state(_x, _y, _colour);

			_i++;
		}
	}
}

draw_possible_state = function(_x, _y, _colour){
	var _drawSubX = x+(SubCellSize*_x);
	var _drawSubY = y+(SubCellSize*_y);
	draw_text_color(_drawSubX+(SubCellSize/2), _drawSubY+(SubCellSize/2), string((_x+(3*_y))+1), _colour, _colour, _colour, _colour, 1);
}

remove_state = function(_i){
	if(possibleStates[_i] == false) return;

	possibleStates[_i] = false;
	possibleStateCount--;
	if(possibleStateCount == 1) set_final(array_get_index(possibleStates, true));
}

set_final = function(_i){
	for(var s = 0; s < 9; s++) possibleStates[s] = false; // shouldn't be necessary, but just incase
	possibleStates[_i] = true; // shouldn't be necessary, but just incase
	possibleStateCount = 1; // shouldn't be necessary, but just incase
	finalState = _i;

	with(obj_Cell) if(finalState == -1){
		if(tileX == other.tileX
		|| tileY == other.tileY
		|| (floor(tileX/3) == floor(other.tileX/3) && floor(tileY/3) == floor(other.tileY/3))
		){
			remove_state(_i);
		}
	}
}

check_for_all_others_impossible = function(_i){
	if(possibleStates[_i] == false) return;

//// "Naked Single" checks
	// only option in meta
	var _multipleOptionsIn_metasquare = false;
	with(obj_Cell) if(id != other.id){
		if(floor(tileX/3) == floor(other.tileX/3) && floor(tileY/3) == floor(other.tileY/3)){
			if(finalState == _i) show_message("it broke");
			if(possibleStates[_i] == true){
				_multipleOptionsIn_metasquare = true;
				break;
			}
		}
	}
	
	if(!_multipleOptionsIn_metasquare) return set_final(_i);
	
	// only option in row
	var _multipleOptionsIn_row = false;
	with(obj_Cell) if(id != other.id){
		if(tileY == other.tileY){
			if(finalState == _i) show_message("it broke");
			if(possibleStates[_i] == true){
				_multipleOptionsIn_row = true;
				break;
			}
		}
	}
	
	if(!_multipleOptionsIn_row) return set_final(_i);
	
	// only option in column
	var _multipleOptionsIn_column = false;
	with(obj_Cell) if(id != other.id){
		if(tileX == other.tileX){
			if(finalState == _i) show_message("it broke");
			if(possibleStates[_i] == true){
				_multipleOptionsIn_column = true;
				break;
			}
		}
	}
	
	if(!_multipleOptionsIn_column) return set_final(_i);
	
//// "Naked Double" checks
}
