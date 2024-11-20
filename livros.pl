% Base de dados de livros
livro('1984', 'George Orwell', 'Ficcao', 'Uma distopia sobre um regime totalitario que controla todos os aspectos da vida.').
livro('Sapiens', 'Yuval Noah Harari', 'Historia', 'Uma breve historia da humanidade desde a pre-historia ate os dias atuais.').
livro('O Poder do Habito', 'Charles Duhigg', 'Autoajuda', 'Explora como os habitos funcionam e como podem ser mudados.').
livro('A Teoria de Tudo', 'Stephen Hawking', 'Ciencia', 'Uma introducao as questoes mais profundas do universo.').

% Generos disponíveis
genero(ficcao).
genero(historico).
genero(ciencia).
genero(autoajuda).

% Regras de recomendacao
recomendar(Titulo) :- 
    livro(Titulo, _, Genero, _),
    interesse(Interesse), 
    (Genero == Interesse ; Interesse == 'todos').

% Captura dos interesses do usuario
interesse(ficcao).
interesse(historico).
interesse(ciencia).
interesse(autoajuda).
interesse(politica).

% Exibe as recomendacoes com base nas escolhas do usuario
consultar_recomendacoes :-
    write('Escolha seu genero (ficcao, historico, ciencia, autoajuda ou todos): '),
    read(Genero),
    write('Escolha seu interesse (ficcao, historico, ciencia, autoajuda ou todos): '),
    read(Interesse),
    findall(Titulo, recomendar(Titulo), ListaRecomendacoes),
    (ListaRecomendacoes \= [] -> 
        write('Recomendacoes:'), nl,
        listar_recomendacoes(ListaRecomendacoes)
    ; 
        write('Nenhuma recomendacao encontrada para os generos escolhidos.'), nl).

% Lista as recomendacoes encontradas
listar_recomendacoes([]).
listar_recomendacoes([Titulo|Restante]) :-
    livro(Titulo, Autor, Genero, Sinopse),
    format('Titulo: ~w | Autor: ~w | Genero: ~w | Sinopse: ~w~n', [Titulo, Autor, Genero, Sinopse]),
    listar_recomendacoes(Restante).

% Para iniciar a consulta
iniciar :-
    consultar_recomendacoes.

% Diretiva de inicializacao para evitar o aviso
:- initialization(iniciar).