function [ index ] = getIndexByState( states, unknownState )
%GETINDEXBYSTATE Funzione che dato uno stato restituisce l'indice di questo
%nel vettore di states, oppure -1 se non lo trova.

nOfStates = size(states,1);
index = -1;

for k=1:nOfStates
    %cerco l'indice corrispondente ad unknownState in States
    if (isequal(states(k,:), unknownState))
        %ho trovato l'elemento in states corrispondente
        index = k;
        break; %not allowed in parfor loops
    end  
end

end

