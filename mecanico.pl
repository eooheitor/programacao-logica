% Base de Conhecimento: Problemas e Sintomas Comuns em Veículos

% Sintomas associados aos problemas
problema(bateria_fraca) :- motor_nao_liga, luzes_fracas.
problema(freio_desgastado) :- barulho_ao_frear, pedal_freio_macio.
problema(vazamento_oleo) :- manchas_de_oleo, nivel_oleo_baixo.
problema(problema_motor) :- motor_falhando, ruido_estranho_motor.
problema(problema_transmissao) :- dificuldade_trocar_marcha, ruido_ao_acelerar.

% Regras para diagnosticar problemas
solucao(bateria_fraca, [
    'Verifique a bateria e limpe os conectores.',
    'Se necessário, substitua a bateria.'
]).
solucao(freio_desgastado, [
    'Verifique as pastilhas e discos de freio.',
    'Substitua as peças desgastadas.'
]).
solucao(vazamento_oleo, [
    'Inspecione o motor e o cárter para identificar o local do vazamento.',
    'Complete o nível de óleo, se necessário.',
    'Leve o carro a um mecânico para reparos.'
]).
solucao(problema_motor, [
    'Verifique as velas de ignição e cabos.',
    'Consulte um mecânico especializado para diagnóstico detalhado.'
]).
solucao(problema_transmissao, [
    'Verifique o nível e a qualidade do fluido de transmissão.',
    'Procure um especialista em transmissões.'
]).

% Conselho geral de segurança
conselho_seguranca([
    'Se não tiver certeza sobre o problema, leve o veículo a um mecânico.',
    'Nunca ignore barulhos estranhos ou falhas no sistema de freios.'
]).

% Captura das informações do usuário
consultar_usuario :-
    write('Descreva o problema do seu veículo respondendo às perguntas abaixo:'), nl,
    capturar_sintomas,
    diagnosticar_problema.

% Capturar sintomas do usuário
capturar_sintomas :-
    perguntar('O motor não liga? (sim/nao)', motor_nao_liga),
    perguntar('As luzes estão fracas? (sim/nao)', luzes_fracas),
    perguntar('O veículo faz barulho ao frear? (sim/nao)', barulho_ao_frear),
    perguntar('O pedal do freio está macio? (sim/nao)', pedal_freio_macio),
    perguntar('Há manchas de óleo no chão? (sim/nao)', manchas_de_oleo),
    perguntar('O nível de óleo está baixo? (sim/nao)', nivel_oleo_baixo),
    perguntar('O motor está falhando? (sim/nao)', motor_falhando),
    perguntar('Há ruídos estranhos no motor? (sim/nao)', ruido_estranho_motor),
    perguntar('Há dificuldade para trocar as marchas? (sim/nao)', dificuldade_trocar_marcha),
    perguntar('Há ruídos ao acelerar? (sim/nao)', ruido_ao_acelerar).

% Auxiliar para capturar respostas do usuário
perguntar(Pergunta, Sintoma) :-
    write(Pergunta), nl,
    read(Resposta),
    (   Resposta == sim -> assertz(Sintoma)
    ;   assertz((Sintoma :- fail)) % Define como falso se a resposta for "nao"
    ).

% Diagnóstico do problema
diagnosticar_problema :-
    (   problema(Problema) ->
        format('Problema identificado: ~w~n', [Problema]),
        fornecer_solucao(Problema)
    ;   write('Não foi possível identificar o problema com base nos sintomas fornecidos.'), nl,
        fornecer_conselho_seguranca
    ).

% Fornecer solução com base no problema diagnosticado
fornecer_solucao(Problema) :-
    solucao(Problema, Solucoes),
    write('Recomendações para o problema identificado:'), nl,
    listar(Solucoes),
    fornecer_conselho_seguranca.

% Fornecer conselhos gerais de segurança
fornecer_conselho_seguranca :-
    conselho_seguranca(Conselhos),
    write('Conselhos de segurança:'), nl,
    listar(Conselhos).

% Listar elementos de uma lista
listar([]).
listar([Primeiro|Resto]) :-
    format('- ~w~n', [Primeiro]),
    listar(Resto).

% Iniciar o sistema
iniciar :-
    write('Bem-vindo ao sistema especialista de análise de problemas em veículos!'), nl,
    consultar_usuario.

% Diretiva de inicialização para iniciar o programa
:- initialization((iniciar -> true ; write('Erro ao iniciar o sistema.'), nl, halt)).
