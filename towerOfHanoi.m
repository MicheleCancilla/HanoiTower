tic
clear all
close all

%% Sezione di training

nOfDisks = 8;
gamma = 0.3;  %fattore di sconto
alpha = 0.9; %learning rate
epsilon = 0.8;  % exploration probability

[ Q , R , states, finalStates ] = init( nOfDisks );

R = mappingR (R , states, finalStates); %funzione che mappa R matrice delle ricompense

Q = trainingQ (Q, states, R , finalStates, gamma, alpha, epsilon);

Q = normalizeQ (Q);

filename = ['hanoi-',num2str(nOfDisks),'.mat'];
save(filename, 'Q', 'states', 'finalStates');

%% Sezione di testing

%init è uno stato random, che non sia uno stato finale
path = searchOptimalPath(Q, states, finalStates);

print = cell(size(path,2),3);
for i=1:size(path,2)
    print(i,:) = getStateByIndex(states, path(i));
end

toc
print
disp(['Numero di mosse: ' num2str(size(path,2))])

