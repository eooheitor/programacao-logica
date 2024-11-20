% Base de dados de evidências e testemunhos
% Fatos sobre evidências
impressao_digital(lugar_crime).
motivo(financeiro).
testemunha(visto_discutindo).
relacao(intima).

% Fatos sobre suspeitos
suspeito(jose).
suspeito(maria).
suspeito(carlos).

% Fatos sobre álibis
alibi(jose, 'Estava em casa com amigos.').
alibi(maria, 'Estava viajando.').
alibi(carlos, 'Estava no trabalho.').
 
% Regras para relacionar evidências a suspeitos
suspeito(jose) :- impressao_digital(lugar_crime), motivo(financeiro).
suspeito(maria) :- testemunha(visto_discutindo), relacao(intima).
suspeito(carlos) :- impressao_digital(lugar_crime), motivo(vinganca).

% Teorias do crime baseadas em evidências
teoria(crime_passional) :- testemunha(visto_discutindo), relacao(intima).
teoria(crime_financeiro) :- motivo(financeiro).

% Consulta para verificar suspeitos
consultar_suspeitos :-
    findall(Suspeito, suspeito(Suspeito), ListaSuspeitos),
    (ListaSuspeitos \= [] ->
        write('Suspeitos encontrados:'), nl,
        listar_suspeitos(ListaSuspeitos)
    ;
        write('Nenhum suspeito encontrado com as evidências fornecidas.'), nl).

% Listar os suspeitos encontrados
listar_suspeitos([]).
listar_suspeitos([Suspeito|Restante]) :-
    format('Suspeito: ~w~n', [Suspeito]),
    listar_suspeitos(Restante).

% Consulta para verificar teorias do crime
consultar_teorias :-
    findall(Teoria, teoria(Teoria), ListaTeorias),
    (ListaTeorias \= [] ->
        write('Teorias do crime encontradas:'), nl,
        listar_teorias(ListaTeorias)
    ;
        write('Nenhuma teoria encontrada com as evidências fornecidas.'), nl).

% Listar as teorias encontradas
listar_teorias([]).
listar_teorias([Teoria|Restante]) :-
    format('Teoria: ~w~n', [Teoria]),
    listar_teorias(Restante).

% Consulta para verificar álibis dos suspeitos
consultar_alibis :-
    write('Informe o nome do suspeito para verificar o álibi: '),
    read(Suspeito),
    (alibi(Suspeito, Alibi) ->
        format('Álibi de ~w: ~w~n', [Suspeito, Alibi])
    ;
        write('Nenhum álibi encontrado para este suspeito.'), nl).

% Iniciar a consulta
iniciar :-
    write('Bem-vindo ao sistema de análise de investigação criminal!'), nl,
    write('Escolha uma opção:'), nl,
    write('1. Consultar Suspeitos'), nl,
    write('2. Consultar Teorias do Crime'), nl,
    write('3. Verificar Álibis'), nl,
    write('4. Sair'), nl,
    read(Op),
    (Op = 1 -> consultar_suspeitos;
     Op = 2 -> consultar_teorias;
     Op = 3 -> consultar_alibis;
     Op = 4 -> write('Saindo...'), nl;
     write('Opção inválida! Tente novamente.'), nl, iniciar).

% Diretiva de inicialização para evitar o aviso
:- initialization(iniciar).