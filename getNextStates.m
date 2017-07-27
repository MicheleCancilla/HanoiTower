function [ nextStates ] = getNextStates( currentState )
%GETNEXTSTATES Funzione che ritorna gli stati raggiungibili da quello corrente

%a seconda dello stato corrente posso avere due stati raggiungibili oppure
%tre
if (isempty(currentState{1,1}) + isempty(currentState{1,2})...
    + isempty(currentState{1,3}) == 2)
    nextStates = {currentState{:};currentState{:}};
else
    nextStates = {currentState{:};currentState{:};currentState{:}};
end

row=1;

%controllo per ogni piolino se posso spostare un disco
for i=1:3
    t = currentState{1,i};
    if (~isempty(t))
        %se entro vuol dire che sul piolo corrente ho un disco
        %provo a fare una mossa per arrivare ad un altro stato
        for j=1:3
            
            temp = currentState{1,j};
            %controllo se il piolo in cui voglio mettere il disco è vuoto,
            %se lo è posso fare una mossa
            if(isempty(temp))
                nextStates{row,i} = t(1,1:(length(t)-2));
                
                nextStates{row,j} = [temp,t(1,length(t))];
                if (isempty(nextStates{row,i}))
                    nextStates{row,i}='';
                end
                row = row + 1;
                %se il piolo in cui voglio mettere il disco NON è vuoto
                %controllo se posso fare una mossa
            elseif (t(1,length(t)) < temp(1,length(temp)))
                %se sono qui ho trovato una mossa valida da poter fare
                
                nextStates{row,i} = t(1,1:(length(t)-2));
                
                nextStates{row,j} = [temp,'-',t(1,length(t)) ];
                if (isempty(nextStates{row,i}))
                    nextStates{row,i}='';
                end
                row = row + 1;
            end
        end
    end
end

%in nextStates ho tutti gli stati raggiungibili, compreso quello corrente

end

