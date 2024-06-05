/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor





// Inherit the parent event
event_inherited();

///method leva_dano(sprite, image_index)
leva_dano = function(_sprite, _image_index){
			
	if(sprite_index != _sprite){
		image_index = 0;
		//vida_atual--;
	}
		
		
	sprite_index = _sprite;
		
	if(vida_atual > 0){
		if(image_index > image_number-1){
			estado = "parado";
		}
	}else{
		if(image_index >= _image_index){
			estado = "morto";
		}
	}
		
}


///@method atacando();
///@args sprite_index, image_index_min, image_index_max, dist_x, dist_y, [xscale_dano], [yscale_dano]
atacando = function(_sprite_index, _image_index_min, _image_index_max, _dist_x, _dist_y, _xscale_dano, _yscale_dano){
	
	if(!_xscale_dano) _xscale_dano = 1;
	if(!_yscale_dano) _yscale_dano = 1;
	
	velh = 0;
	if(sprite_index != _sprite_index){
		sprite_index = _sprite_index;
		image_index = 0;
		posso = true;
		dano = noone;
	}
		
	if(image_index	> image_number-1){
		estado = "parado";
	}
		
	if(image_index >= _image_index_min && dano == noone && image_index <= _image_index_max && posso){
		dano = instance_create_layer(x + _dist_x, y + _dist_y, layer, obj_dano);
		dano.dano = ataque;
		dano.pai = id;
		dano.image_xscale = _xscale_dano;
		dano.image_yscale = _yscale_dano
		posso = false;
	}

				
	if(dano != noone && image_index > _image_index_max){
		instance_destroy(dano);
		dano = noone;
	}

}

//method morrendo(sprite)
morrendo = function(_sprite){
	velh = 0;
	if(sprite_index != _sprite){
		image_index = 0;
	}
		
	sprite_index = _sprite;
		
	if(image_index > image_number-1){
		image_speed	= 0;
		image_alpha -= .01;
		if(image_alpha <= 0){
			instance_destroy();
		}
	}
}