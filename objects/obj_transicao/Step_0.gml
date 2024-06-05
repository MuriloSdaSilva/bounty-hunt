/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(mudeiRoom){
	alpha -= .01
}else{
	alpha += .01
}

if(alpha >= 1){
	room_goto(destino)
	
	obj_player.x = destino_x
	obj_player.y = destino_y
}

if(mudeiRoom && alpha <= 0){
	instance_destroy();
}
