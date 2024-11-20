% Fatos (sintomas informados pelo usuário)
sintoma(febre).
sintoma(tosse).
sintoma(cansaco).
sintoma(dor_de_garganta).
sintoma(dor_muscular).
sintoma(dor_de_cabeca).
sintoma(nausea).

% Regras de diagnóstico
doenca(gripe) :- sintoma(febre), sintoma(tosse), sintoma(cansaco).
doenca(infeccao_viral) :- sintoma(febre), sintoma(dor_de_garganta), sintoma(dor_muscular).
doenca(enxaqueca) :- sintoma(dor_de_cabeca), sintoma(nausea).

% Função principal para iniciar o diagnóstico
diagnosticar :-
write('Digite os sintomas (como uma lista, por exemplo: [febre, tosse]): '),
read(Sintomas),
diagnosticar_doenca(Sintomas).

% Função para diagnosticar com base nos sintomas informados
diagnosticar_doenca(Sintomas) :-
findall(Doenca, (member(S, Sintomas), sintoma(S), doenca(Doenca)), Doencas),
sort(Doencas, DoencasUnicas),  % Remove duplicatas
(   DoencasUnicas \= [] -> 
write('Possível diagnóstico: '), write(DoencasUnicas), nl
;   alerta
).

% Alerta quando a doença não for identificada
alerta :- write('Recomendação: Consultar um médico.\n').


No terminal:

diagnosticar.
[febre, tosse].