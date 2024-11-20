% Base de dados de treinos e exercícios
% Fatos sobre treinos
treino(hipertrofia, 'Treino de Hipertrofia', [
    exercicio(banco_suporte, 4, 8, 'Supino reto com barra.'),
    exercicio(agachamento, 4, 10, 'Agachamento com barra nas costas.'),
    exercicio(levantamento_terra, 3, 8, 'Levantamento terra com barra.'),
    exercicio(puxada_frente, 3, 10, 'Puxada na frente no pulley.'),
    exercicio(curl_biceps, 3, 12, 'Curl de bíceps com halteres.')
]).

treino(perda_de_peso, 'Treino para Perda de Peso', [
    exercicio(corrida, 1, 30, 'Corrida contínua por 30 minutos.'),
    exercicio(pular_corda, 5, 1, 'Pular corda por 1 minuto entre os exercícios.'),
    exercicio(abdominais, 3, 15, 'Abdominais tradicionais.'),
    exercicio(flexoes, 3, 10, 'Flexões de braço.'),
    exercicio(agachamento_peso_corpo, 3, 15, 'Agachamentos sem peso.')
]).

treino(condicionamento_fisico, 'Treino para Condicionamento Físico', [
    exercicio(corrida_intervalada, 5, 2, 'Corrida intervalada: correr por 2 minutos e caminhar por 1 minuto.'),
    exercicio(bicicleta_estatica, 1, 20, 'Bicicleta estática por 20 minutos.'),
    exercicio(puxada_horizontal, 3, 12, 'Puxada horizontal no pulley.'),
    exercicio(salto_completo, 3, 10, 'Saltos completos (burpees).')
]).

% Regras para associar objetivos a planos de treino
recomendar_treino(Treino) :-
    objetivo(Objetivo),
    experiencia(Experiencia),
    disponibilidade(Disponibilidade),
    (   (Objetivo == ganhar_massa -> Treino = hipertrofia;
        Objetivo == emagrecer -> Treino = perda_de_peso;
        Objetivo == melhorar_condicionamento -> Treino = condicionamento_fisico)
    ),
    (   (Experiencia == intermediario; Disponibilidade == tempo_limitado) ->
        true
    ;
        write('Considere ajustar seu plano de treino com base na sua experiência e disponibilidade.'), nl).

% Captura das informações do usuário
consultar_informacoes :-
    write('Qual é o seu objetivo? (ganhar_massa / emagrecer / melhorar_condicionamento): '),
    read(Objetivo),
    assertz(objetivo(Objetivo)),
    
    write('Qual é o seu nível de experiência? (iniciante / intermediario / avancado): '),
    read(Experiencia),
    assertz(experiencia(Experiencia)),
    
    write('Qual é a sua disponibilidade de tempo? (tempo_limitado / tempo_abundante): '),
    read(Disponibilidade),
    assertz(disponibilidade(Disponibilidade)),

    recomendar_treino(Treino),
    
    format('Treino recomendado: ~w~n', [Treino]),
    
    listar_exercicios(Treino).

% Listar os exercícios do treino recomendado
listar_exercicios(Treino) :-
    treino(Treino, NomeTreino, Exercicios),
    format('Plano de Treino: ~w~n', [NomeTreino]),
    listar_exercicios_detallados(Exercicios).

listar_exercicios_detallados([]).
listar_exercicios_detallados([exercicio(NomeExercicio,Sessao,R,instrucao)|Restante]) :- % Corrigido aqui
    format('Exercício: ~w | Séries: ~w | Repetições: ~w | Instruções: ~w~n', [NomeExercicio,Sessao,R,instrucao]),
    listar_exercicios_detallados(Restante).

% Iniciar a consulta
iniciar :-
    write('Bem-vindo ao sistema de recomendação de treinos!'), nl,
    consultar_informacoes.

% Diretiva de inicialização para evitar o aviso
:- initialization(iniciar).