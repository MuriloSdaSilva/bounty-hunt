/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
var player = place_meeting(x, y, obj_player)

var espaco = keyboard_check_released(vk_space)


if(player && espaco){
	var transicao = instance_create_layer(0, 0,	layer, obj_transicao)
	transicao.destino = destino;
	transicao.destino_x = destino_x;
	transicao.destino_y = destino_y;

}



