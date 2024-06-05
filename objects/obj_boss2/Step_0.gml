/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
var chao = place_meeting(x, y + 1, obj_block);
if(!chao){
	velv += GRAVIDADE * massa  * global.vel_mult;	
}


switch(estado){

	#region parado
	case "parado":{
		velh = 0;
		timer_estado++;
		
		if(sprite_index != spr_boss2_idle){
			sprite_index = spr_boss2_idle
			image_index = 0;
		}
		
		if(instance_exists(obj_player)){
			var _dist = point_distance(x, y, obj_player.x, obj_player.y);
			if(_dist < 300){
				estado = "andando"
			}
		}
		
	}
	#endregion
	
	#region andando
	case "andando":{
		timer_estado++;
		if(sprite_index != spr_boss2_walk){
			sprite_index = spr_boss2_walk;
			image_index = 0;
		}
		
		if(instance_exists(obj_player)){
			
			var _dist = point_distance(x, y, obj_player.x, obj_player.y);
			var _dir = point_direction(x, y, obj_player.x, obj_player.y);
			
			if(_dist > 100){
				velh = lengthdir_x(max_velh, _dir)
			}else{
				velh = 0;
				estado = "ataque"
			}
		}
		
		break;
	}
	#endregion
	
	#region ataque
	case "ataque":{
		atacando(spr_boss2_attack, 9, 12, sprite_width/2, -sprite_height/2, 1.5, 1.5)
		break;
	}
	#endregion
	
	#region golpeado
	case "golpeado":{
		leva_dano(spr_boss2_hit, 4)
		break;
	}
	#endregion
	
	#region morto
	case "morto":{
		morrendo(spr_boss2_death);
		screenshake(1.5)
		break;
	}
	#endregion
	
}






