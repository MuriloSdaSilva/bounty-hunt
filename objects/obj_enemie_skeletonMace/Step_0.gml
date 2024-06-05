/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var chao = place_meeting(x, y + 1, obj_block);

if(!chao){
	velv += GRAVIDADE * massa  * global.vel_mult;	
}


switch(estado){
	
	#region parado
	case "parado":
	{
		velh = 0;
		timer_estado++;
		if(sprite_index != spr_skeletonMace_idle){
			image_index = 0;
		}
		
		
		sprite_index = spr_skeletonMace_idle;
		
		
		if(irandom(timer_estado) > 120){
			estado = choose("andando", "parado", "andando");
			timer_estado = 0;
		}
		
		scr_ataca_player_melee(obj_player, dist, xscale);

		break;
	}
	#endregion
	
	#region andando
	case "andando":
	{

		timer_estado++;
		if(sprite_index != spr_skeletonMace_walk){
			image_index = 0;
			velh = choose(1, -1);
		}
		sprite_index = spr_skeletonMace_walk;
		
		//voltando para o estado parado
		if(irandom(timer_estado) > 240){
			estado = choose("andando", "parado", "parado");
			timer_estado = 0;
		}
		
		scr_ataca_player_melee(obj_player, dist, xscale);

		
		break;
	}
	#endregion
	
	#region ataque
	case "ataque":
	{
		atacando(spr_skeletonMace_attack, 3, 4, sprite_width/3, -sprite_height/2)
		/*velh = 0;
		if(sprite_index != spr_skeleton_attack){
			image_index = 0;
			posso = true;
			dano = noone;
		}
		sprite_index = spr_skeleton_attack;
		
		if(image_index	> image_number-1){
			estado = "parado";
		}
		
		if(image_index >= 7 && dano == noone && image_index <= 8 && posso){
			dano = instance_create_layer(x + sprite_width/1.8, y - sprite_height/2, layer, obj_dano);
			dano.dano = ataque;
			dano.pai = id;
			posso = false;
		}

				
		if(dano != noone && image_index > 8){
			instance_destroy(dano);
			dano = noone;
		}*/
		
		
		
		break;
	}
	
	#endregion
	
	#region golpeado
	case "golpeado":
	{
		
		//delay = room_speed * 2;
		//velh = 0
		
		leva_dano(spr_skeletonMace_hit, 2)
	
		
		break;
	}
	#endregion
	
	#region morto
	case "morto":
	{
		morrendo(spr_skeletonMace_death);
		break;
	}
	#endregion
}

if(delay > 0){
	delay--;
}