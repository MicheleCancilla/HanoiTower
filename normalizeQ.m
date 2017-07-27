function [ Q ] = normalizeQ( Q )
%NORMALIZEQ Normalizzo la matrice Q dividend ogni suo elemento
%per il suo elemento maggiore

maxValue = max(Q(:));

Q = Q./maxValue;

end

