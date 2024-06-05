/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if(game_over){
	var x1 = camera_get_view_x(view_camera[0]);
	var w = camera_get_view_width(view_camera[0]);

	
	var x2 = x1 + w;
	var meio_w = x1 + w/2;
	
	var y1 = camera_get_view_y(view_camera[0]);
	var h = camera_get_view_height(view_camera[0]);
	
	var y2 = y1 + h;
	var meio_h = y1 + h/2
	
	var qtd = h * .15;	
	
	valor = lerp(valor, 1, .02);
	
	draw_set_color(c_black);
	
	//escurece a tela 
	draw_set_alpha(valor - .4);
	draw_rectangle(x1, y1, x2, y2, false)
	
	draw_set_alpha(1);
	//desenha na parte de cima
	draw_rectangle(x1, y1, x2, y1 + qtd * valor, false);
	
	//desenha na parte de baixo
	draw_rectangle(x1, y2, x2, y2 -qtd * valor, false);
	
	draw_set_alpha(1);
	draw_set_color(-1);
	
	if(valor > 0.85){
		
		cont = lerp(cont, 1, 0.1);
		draw_set_alpha(cont);
		
		draw_set_font(fnt_game_over)
		draw_set_valign(1);
		draw_set_halign(1);
	
		draw_text(meio_w, meio_h, "G a m e  O v e r");
		draw_set_font(-1)
		
		draw_text(meio_w, meio_h + 50, "Pressione ENTER para iniciar um novo jogo");
	
		draw_set_valign(-1);
		draw_set_halign(-1);
		
		draw_set_alpha(-1);
	}
}else{
	valor = 0;
}




