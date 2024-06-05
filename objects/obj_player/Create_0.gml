/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
randomize();

var cam = instance_create_layer(x, y, layer, obj_camera);
cam.alvo = id;

// Inherit the parent event
event_inherited();

max_vida = 10;
vida_atual = max_vida;
ataque = 20;

max_velh = 4;
max_velv = 6;
roll_vel = 4.5;
combo = 0;
dano = noone;
ataque = 1;
possoAtacar = true;
ataque_combo = 1;
ataque_buff = room_speed;

invencivel = false;
invencivel_timer = room_speed * 1
tempo_invencivel = invencivel_timer

roll_delay = room_speed * 2;
roll_timer = 0;

mostra_estado = true;