/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
//if((room_get_name(rm_menu)) == "rm_menu"){
audio_play_sound(musica_menu,1,1)
/*}else{
	audio_play_sound(musica_menu,0,1)
}*/


selecionar = 0;
valor_margin = 0
margin_total = 12
pagina = 0;

#region metodos

desenha_menu = function(_menu){

	draw_set_font(fnt_menu)

	var _qtd = array_length(_menu);
	var _alt = display_get_gui_height();
	var _larg = display_get_gui_width()
	

	var _espaco_y = string_height("I") + 16
	var _alt_menu = _espaco_y * _qtd

	define_align(1, 0)

	for(var i = 0; i < _qtd; i++){
		var _cor = c_silver, _margx = 0;
		var _texto = _menu[i][0];
	
		if(menu_selecionar[pagina] == i){
			_cor = c_red
			_margx = valor_margin;
		}
	
		draw_text_color(20 + _margx, (_alt / 2) -_alt_menu/2 + (i * _espaco_y), _texto, _cor, _cor, _cor, _cor, 1);

	}
	
	for(var i = 0; i < _qtd; i++){
		switch(_menu[i][1]){
			case menu_acoes.ajustes_menu:{
				var _indice = _menu[i][3];
				var _txt = _menu[i][4][_indice]
				
				var _esq = _indice > 0 ? "<< " : ""
				var _dir = _indice < array_length(_menu[i][4]) - 1 ? " >>" : "";
				
				var _cor = c_silver
				
				if(alterando && menu_selecionar[pagina] == i){
					_cor = c_red;
				}
			
				draw_text_color(_larg/2, (_alt / 2) -_alt_menu/2 + (i * _espaco_y), _esq + _txt + _dir, _cor, _cor, _cor, _cor, 1)
			
				break;
			}
		}
	}
	
	
	draw_set_font(-1);
	define_align(-1, -1)

}

controla_menu = function(_menu){
	var _up, _down, _left, _right, _confirmar, _voltar;
	
	var _sel = menu_selecionar[pagina]
	
	_up = keyboard_check_pressed(vk_up);
	_down = keyboard_check_pressed(vk_down);
	_right = keyboard_check_pressed(vk_right);
	_left = keyboard_check_pressed(vk_left);
	_confirmar = keyboard_check_released(vk_enter);
	_voltar = keyboard_check_pressed(vk_escape);

	if(!alterando){
		if(_up || _down){
	
			menu_selecionar[pagina] += _down - _up;
	
			var _tamanho = array_length(_menu) - 1;
			menu_selecionar[pagina] = clamp(menu_selecionar[pagina], 0, _tamanho)
			//valor_margin = 0;
		}
	}else{
	
		if(_right || _left){
			var _limite = array_length(_menu[selecionar][4]);
			
			menus[pagina][selecionar][3] += _right - _left;
			menus[pagina][selecionar][3] = clamp(menus[pagina][selecionar][3], 0,  _limite)
		}
		
	}
		
	
	if(_confirmar){
		switch(_menu[_sel][1]){
			case menu_acoes.roda_metodo: _menu[_sel][2](); break;
			case menu_acoes.carrega_menu: pagina = _menu[_sel][2]; break; 
			case menu_acoes.ajustes_menu:{
				alterando = !alterando; 
				
				if(!alterando){
					var _arg = _menu[selecionar][3];
					_menu[selecionar][2](_arg)
				}
				break;
			}
		}
	}
	
	valor_margin = margin_total * valor_ac(ac_margin, _up ^^ _down)//lerp(valor_margin, margin_total, .2)
}

inicia_jogo = function(){
	audio_stop_sound(musica_menu)
	audio_play_sound(musica_ambiente,1,1)
	room_goto(Room1)
}

fecha_jogo = function(){
	game_end();
}
	
ajusta_tela = function(_valor){
	
	switch(_valor){
	
		case 0:{
			window_set_fullscreen(true);
			break;
		}
		case 1:{
			window_set_fullscreen(false);
		}
	
	}
	
}
	
ajusta_dificuldade = function(_valor){
	switch(_valor){
		case 0: global.dificuldade = .5; break;
		case 1: global.dificuldade = 1; break;
		case 2: global.dificuldade = 1.5; break;
		case 3: global.dificuldade = 5; break;
	}
}

#endregion

menu_principal = [
					["Iniciar", menu_acoes.roda_metodo, inicia_jogo],
					["Opções", menu_acoes.carrega_menu, menus_lista.opcoes],
					["Sair", menu_acoes.roda_metodo, fecha_jogo]
];


menu_opcoes = [
				["Alterar Janela", menu_acoes.carrega_menu, menus_lista.tela],
				["Dificuldade", menu_acoes.carrega_menu, menus_lista.dificuldade],	
				["Voltar", menu_acoes.carrega_menu, menus_lista.principal]
]

menu_dificuldade = [
						["Dificuldade", menu_acoes.ajustes_menu, ajusta_dificuldade, 1, ["Fácil", "Normal", "Difícil", "Extremo"]],
						["Voltar", menu_acoes.carrega_menu, menus_lista.opcoes]
]

menu_tela = [
				["Modo de exibição", menu_acoes.ajustes_menu, ajusta_tela, 1, ["Tela Cheia", "Modo Janela"]],
				["Voltar", menu_acoes.carrega_menu, menus_lista.opcoes]
]


menus = [menu_principal, menu_opcoes, menu_tela, menu_dificuldade];
menu_selecionar = array_create(array_length(menus), 0)
alterando = false;