function [ R ] = mappingR( R , states, finalStates )
%MAPPINGR Funzione che mappa la matrice delle ricompense R. Imposto anche
%gli stati raggiungibili da ciascuno stato corrente.

nOfStates = size(states,1);
currentState = cell(1,3);

for i=1:nOfStates
    currentState{1,1} = states{i,1};
    currentState{1,2} = states{i,2};
    currentState{1,3} = states{i,3};
    
    nextStates = getNextStates(currentState);
    
    [numNextStates,~] = size(nextStates);
    %avendo trovato gli stati raggiungibili mappo R (matrice di ricompense)
    %con 0 se lo stato è raggiungibile o 100 se lo stato raggiungibile è
    %anche quello finale. tengo conto degli indici della matrice states
    for j=1:numNextStates
        for k=1:nOfStates
            %cerco l'indice corrispondente ad ogni stato di nextStates in
            %States
            if (isequal(states(k,:), nextStates(j,:)))
                %ho trovato l'elemento in states corrispondente
                %posso settare la riga di R corrispondente
                if (find(finalStates == k))
                    R(i,j,1) = 100;
                else
                    R(i,j,1) = 0;
                end
                R(i,j,2) = k;
                %ho trovato l'unica corrispondenza, quindi vado alla
                %prossima iterazione
                continue;
            end
        end
    end
end
end

