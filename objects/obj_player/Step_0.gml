/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(instance_exists(obj_transicao)) exit;

if(invencivel && tempo_invencivel > 0){
	tempo_invencivel--;
	image_alpha = max(sin(get_timer()/100000), 0.2)
}else{
	invencivel = false;
	image_alpha = 1;
}

if(roll_timer > 0){
	roll_timer--;
}

var right, left, jump, attack;
var chao = place_meeting(x, y + 1, obj_block);

right = keyboard_check(ord("D"));
left = keyboard_check(ord("A"));
jump = keyboard_check_pressed(ord("W"));
attack = keyboard_check_pressed(ord("J"));
roll = keyboard_check_pressed(ord("L"));

if(ataque_buff > 0 ){
	ataque_buff -= 1;
}

//gravidade
if(!chao){
	if(velv < max_velv * 2){
		velv += GRAVIDADE * massa * global.vel_mult;
	}
}
//movimentação
velh = (right - left) * max_velh * global.vel_mult;

switch(estado){
	
	#region parado
	
	case "parado":
	{
		sprite_index = spr_player_stop1;
		
		if(velh != 0){
			estado = "movendo";
		}else if(jump || velv != 0){
			estado = "pulando";
			velv = (-max_velv * jump);
			image_index = 0;
		}else if(attack){
			estado = "ataque";
			velh = 0;
			image_index = 0;
		}else if(roll && roll_timer <= 0){
			estado = "roll";
			image_index = 0;
		}
		
		
		break;	
	}
	#endregion
	
	#region movendo
	case "movendo":
	{
		sprite_index = spr_player_run;
		if(abs(velh) < .1){
			estado = "parado";
			velh = 0;
			
		}else if(jump || velv != 0){
			estado = "pulando";
			velv = (-max_velv * jump);
			image_index = 0;
		}else if(attack){
			estado = "ataque";
			velh = 0;
			image_index = 0;
		}else if(roll && roll_timer <= 0){
			estado = "roll";
			image_index = 0;
		}
		
		break;
	}
	
	#endregion
	
	#region pulando
	case "pulando":
	{
		if(velv > 0){
			sprite_index = spr_player_fall
			if(image_index >= image_number-1){
				image_index = image_number-1;
			}
		}else{
			sprite_index = spr_player_jump
			if(image_index >= image_number-1){
				image_index = image_number-1;
			}
		}
		
		if(attack){
			estado = "ataque_aereo";
		}
		
		if(chao){
			estado = "parado";
			velh = 0;
		}
		break;
	}
	#endregion
	
	#region ataque_aereo
	
	case "ataque_aereo":{
		if(sprite_index != spr_player_attack_air){
			sprite_index = spr_player_attack_air;
			image_index = 0;
		}
		
		if(image_index >= 1 && dano == noone && possoAtacar){
			dano = instance_create_layer(x + sprite_width/2.8 + velh * 2, y - sprite_height/2, layer, obj_dano);
			dano.dano = ataque;
			dano.pai = id;
			possoAtacar = false;
		}
		
		
		
		if(image_index >= image_number -1){
			estado = "pulando";
			possoAtacar = true;
			if(dano){
				instance_destroy(dano, false);
				dano = noone;
			}
		}if(chao){
			estado = "parado";
			possoAtacar = true;
			if(dano){
				instance_destroy(dano, false);
				dano = noone;
			}
		}
		
		break;
	}
	
	#endregion
	
	#region ataque
	case "ataque":
	{
		velh = 0;
		
		//sistema de combo
		if(combo == 0){
			sprite_index = spr_player_attack;	
		}else if(combo == 1){
			sprite_index = spr_player_attack2;
		}else if(combo == 2){
			sprite_index = spr_player_attack3;
		}
		
		//criando objeto dano
		if(image_index >= 2 && dano == noone && possoAtacar){
			dano = instance_create_layer(x + sprite_width/2.8, y - sprite_height/2, layer, obj_dano);
			dano.dano = ataque + ataque_combo;
			dano.pai = id;
			possoAtacar = false;
		}
		
		if(attack && combo < 2){
			ataque_buff = room_speed;
		}
		
		
		
		if(ataque_buff && combo < 2 && image_index >= image_number-2){
			combo++;
			image_index = 0;
			possoAtacar = true;
			ataque_combo += 0.5
			if(dano){
				instance_destroy(dano, false);
				dano = noone;
			}
			
			ataque_buff = 0;
		}
		
		if(image_index > image_number-1){
			estado = "parado"
			velh = 0;
			combo = 0;
			possoAtacar = true;
			ataque_combo = 1;
			if(dano){
				instance_destroy(dano, false);
				dano = noone;
			}
		}if(roll && roll_timer <= 0){
			estado = "roll";
			image_index = 0;
			combo = 0;
			if(dano){
				instance_destroy(dano, false);
				dano = noone;
			}
		}if(velv != 0){
			estado = "pulando";
			image_index = 0;
		}
		break;
	}
	#endregion
	
	#region roll
	case "roll":{
		if(sprite_index != spr_player_roll){
			sprite_index = spr_player_roll;
			image_index = 0;
		}
		
		velh = image_xscale * roll_vel;
		
		if(image_index >= image_number - 1 || !chao){
			estado = "parado";
			roll_timer = roll_delay
		}
		break;
	}
	#endregion
	
	#region golpeado
	case "golpeado":
	{
		if(sprite_index != spr_player_hit){
			sprite_index = spr_player_hit;
			image_index = 0;
			
			screenshake(2);
			
			invencivel = true;
			tempo_invencivel = invencivel_timer
			
		}
		
		velh = 0;
		
		if(vida_atual > 0){
			if(image_index >= image_number - 1){
				estado = "parado";
			}
		}else{
			if(image_index >= image_number - 1){
				estado = "morto"
			}
		}
		
		break;
	}
	#endregion
	
	#region morto
	case "morto":{
		
		if(instance_exists(obj_game_controller)){
			with(obj_game_controller){
				game_over = true;
			}
		}
		
		velh = 0;
		if(sprite_index != spr_player_death){
			image_index = 0;
			sprite_index = spr_player_death
		}
		
		if(image_index >= image_number-1){
			image_index = image_number-1;
		}
		
		break;
	}
	
	#endregion
	
	default:{
		estado = "parado";
	}
}


if(keyboard_check(vk_enter)) game_restart();


