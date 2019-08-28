function E = estimateEmatrix(X1,X2)
% Estimate E matrix given a set of 
% pairs of matching *calibrated* points
% X1,X2: Nx2 matrices of calibrated points
%   i^th row of X1 matches i^th row of X2

% Kronecker products
% Your code goes here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r = size(X1,1);
c = ones(r, 1);
X1 = [X1 c];
X2 = [X2 c];
A = zeros(r,9);

for i = 1:r
     
    A(i,:) = kron(X1(i,:),X2(i,:));
end

[U,S,V] = svd(A);

e = V(:,9);

E = reshape(e,3,3);
% E = transpose(E);
% Project E on the space of essential matrices
[U,S,V] = svd(E);
D = [1 1 0];
D = diag(D);
E = U * D * V';
end 


% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
