function [ path ] = searchOptimalPath(Q, states, finalStates )
%SEARCHOPTIMALPATH Funzione che cerca il path migliore dallo stato init
%fino allo stato finale
initIndex = 1;

%creo uno stato iniziale che non può essere uno degli stati finali
while((find(finalStates == initIndex, 1)))
    initIndex = randi(size(states,1));
end

path = initIndex;

while(isempty(find(finalStates == initIndex, 1)))
    [~,nextStateIndex] = max(Q(initIndex,:));
    
    path = [ path nextStateIndex ];
    
    initIndex = nextStateIndex;
end


end

