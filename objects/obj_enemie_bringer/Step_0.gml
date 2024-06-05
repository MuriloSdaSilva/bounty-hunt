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
		if(sprite_index != spr_bringer_idle){
			image_index = 0;
		}
		
		
		sprite_index = spr_bringer_idle;
		
		
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
		if(sprite_index != spr_bringer_walk){
			image_index = 0;
			velh = choose(1, -1);
		}
		sprite_index = spr_bringer_walk;
		
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
		atacando(spr_bringer_attack, 4, 7, sprite_width/2.5, -sprite_height/2)
		break;
	}
	
	#endregion
	
	#region golpeado
	case "golpeado":
	{
		
		//delay = room_speed * 2;
		//velh = 0
		
		leva_dano(spr_bringer_hit, 2)
	
		
		break;
	}
	#endregion
	
	#region morto
	case "morto":
	{
		morrendo(spr_bringer_death);
		break;
	}
	#endregion
}

if(delay > 0){
	delay--;
}