function [ Q ] = trainingQ( Q, states, R , finalStates, gamma, alpha, epsilon)
%TRAININGQ Funzione che fa il learning della matrice Q fino a convergenza

nOfStates = size(states,1);

%alleno la matrice Q
for i=1:(3*nOfStates)
    
    initialStateIndex = randi(nOfStates);
    currentStateIndex = initialStateIndex;
    
    while(isempty(find(finalStates == currentStateIndex, 1)))
        
        r=rand; % get 1 uniform random number
        x=sum(r>=cumsum([0, 1-epsilon, epsilon])); % check it to be in which probability area
        %scelgo con probabilità 1-epsilon il valore massimo in Q(exploit)
        %e con prob epsilon uno a caso tra questi (explore).
        
        if  (x == 1)   % exploit
            
            [val,nextStateIndex] = max(Q(currentStateIndex,:));
            if val == 0
                %caso in cui nextStateIndex vale 1 perchè in quella riga Q
                %ha sempre valore 0, in questo casto scelgo casualmente uno
                %degli stati successivi possibili
                nextStateIndex = -1;
                while nextStateIndex == -1
                    nextStateIndex = R(currentStateIndex,randi(3),2);
                end
            end
            
        else        % explore
            nextStateIndex = -1;
            while nextStateIndex == -1
                nextStateIndex = R(currentStateIndex,randi(3),2);
            end
        end
        
        %cerco la colonna corrispondente alla prossima azione nella matrice R
        for j=1:3
            if R(currentStateIndex, j, 2) == nextStateIndex
                IndexInR = j;
            end
        end
                
        %trovo il valore massimo dell'azione eseguita dal nextState
        [maxVal,~] = max(Q(nextStateIndex,:));
        
        %formula di aggiornamento di Q caso deterministico
        Q(currentStateIndex, nextStateIndex) = ...
            Q(currentStateIndex, nextStateIndex) + ...
            alpha * (R(currentStateIndex, IndexInR, 1) + gamma *...
            maxVal - Q(currentStateIndex, nextStateIndex));
        
        currentStateIndex = nextStateIndex;
    end
    
end
end

