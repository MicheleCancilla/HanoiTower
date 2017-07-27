function [ Q , R , states, finalStates ] = init( nOfDisks )
%LEARNING Summary of this function goes here
%   Detailed explanation goes here

%fissando il numero di pioli a 3, il numero di stati totali è:
nOfStates = 3^nOfDisks;

%Inizializzo Q a zero
Q = zeros(nOfStates,nOfStates);

%R è una matrice con nOfStates righe e 3 colonne. Ogni elemento consta di
%due campi: con indice 1 si fa riferimento alla ricompensa, con indice 2 si
%fa riferimento allo stato corrispondente in states (indice)
R = ones(nOfStates,3,2).*-1;

x = 'ABC';                  % Insieme dei 3 pioli
K = nOfDisks;               % dimensione della permutazione

% Creo tutte le disposizioni di 3 elementi con ripetizione
C = cell(K, 1);             % Alloco un cell array
[C{:}] = ndgrid(x);         % creo K griglie di valori
y = cellfun(@(x){x(:)}, C); % Convertto le griglie in vettori colonna
y = [y{:}];                 % Ottengo le permutazioni

states = cell(nOfStates, 3);

for i=1:nOfStates
    A = '';
    B = '';
    C = '';
    for j=nOfDisks:-1:1
        if ( y(i,j) == 'A' )
            if ( ~isempty(A))
                A = [A, '-'];
            end
            A = [A, num2str(j)];
        end
        if ( y(i,j) == 'B' )
            if ( ~isempty(B))
                B = [B, '-'];
            end
            B = [B, num2str(j)];
        end
        if ( y(i,j) == 'C' )
            if (  ~isempty(C))
                C = [C, '-'];
            end
            C = [C, num2str(j)];
        end
    end
    %qui ho uno stato completo
    states{i,1} = A;
    states{i,2} = B;
    states{i,3} = C;
end

finalStates = zeros(1,3);
j=1;
%cerco gli stati finali
for i=1:nOfStates
    if (  (isempty(states{i,1}) +  isempty(states{i,2}) +  isempty(states{i,3})) > 1 )
        finalStates(j) = i ;
        j = j + 1;
    end
end

end

