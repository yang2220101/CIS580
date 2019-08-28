function [transfoCandidates] = poseCandidatesFromE(E)
% Return the 4 possible transformations for an input matrix E
% transfoCandidates(i).T is the 3x1 translation
% transfoCandidates(i).R is the 3x3 rotation

transfoCandidates = repmat(struct('T',[],'R',[]),[4 1]);
% Fill in the twisted pair for E and the twisted pair for -E
% The order does not matter.

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[U S V] = svd(E);
Z = [0 -1 0;1 0 0;0 0 1];
T = U(:,3);

R = U * Z * V';
RT = U * Z' * V';
T1 = T;
T2 = -T;

transfoCandidates(1).T=T1;
transfoCandidates(1).R=R;

transfoCandidates(2).T=T2;
transfoCandidates(2).R=R;

transfoCandidates(3).T=T1;
transfoCandidates(3).R=RT;

transfoCandidates(4).T=T2;
transfoCandidates(4).R=RT;

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%