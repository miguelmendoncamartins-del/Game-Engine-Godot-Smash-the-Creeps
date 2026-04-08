extends Node

@export var mob_scene: PackedScene

func _ready():
	# Conexão segura: verificamos se o nó existe e se tem o sinal
	if has_node("Player"):
		var player = $Player
		if player.has_signal("hit"):
			player.hit.connect(_on_player_hit)
		else:
			push_error("Erro: O sinal 'hit' não foi encontrado no script do Player!")
	else:
		push_error("Erro: O nó 'Player' não foi encontrado na cena Main!")

func _on_mob_timer_timeout():
	# Cria uma instância do monstro
	var mob = mob_scene.instantiate()

	# Seleciona um local aleatório no Path3D
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	var player_position = $Player.global_position
	mob.initialize(mob_spawn_location.global_position, player_position)

	# Adiciona o monstro à cena
	add_child(mob)
	
	# Conecta o sinal de 'squashed' do monstro à interface (ajustado para sintaxe do Godot 4)
	if has_node("UserInterface/ScoreLabel"):
		mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed)

func _on_player_hit():
	print("Game Over")
	$MobTimer.stop() # Opcional: para o jogo quando o player morre
