///@arg player
///@arg dist
///@arg xscale
function scr_ataca_player_melee(argument0, argument1, argument2){
	
	var outro = argument0;
	var dist = argument1;
	var xscale = argument2;




	var player = collision_line(x, y - sprite_height/2, x + (dist * xscale), y - sprite_height/2, outro, 0, 1);

	if(player){
		estado = "ataque";
	}
}