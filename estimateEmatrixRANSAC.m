function [E, bestInliers] = estimateEmatrixRANSAC(X1,X2)
% Estimate E matrix given a set of 
% pairs of matching *calibrated* points
% X1,X2: Nx2 matrices of calibrated points
%   i^th row of X1 matches i^th row of X2
%
% E: robustly estimated E matrix
% bestInliers: indices of the rows of X1 (and X2) that where in the
% largest consensus set

nIterations = 1000;
sampleSize = 8;

%fractionInliers = 0.6;
%nInliers = floor((size(X1,1) - sampleSize) * fractionInliers);
%bestError = Inf;
eps = 10^(-4);
bestNInliers = 0;

for i=1:nIterations
    indices = randperm(size(X1,1));
    sampleInd = indices(1:sampleSize);
    testInd =  indices(sampleSize+1:length(indices));
    
    % Your code goes here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    X1E = X1(sampleInd,:);
    X2E = X2(sampleInd,:);
    E_sample = estimateEmatrix(X1E, X2E);
    curInliers = [];
    for j = 1:length(testInd)
        X1R = X1(testInd(j),:);
        X2R = X2(testInd(j),:);
        e3 = [0 -1 0; 1 0 0; 0 0 0];
        r = size(X1R,1);
        c = ones(r, 1);
        X1R = [X1R c];
        X2R = [X2R c];
        residuals = (X2R * E_sample * (X1R)')^2 / (norm(e3 * E_sample * (X1R)'))^2+(X1R * E_sample * (X2R)')^2 / (norm(e3 * E_sample * (X2R)'))^2;
    
    
                            % Vector of residuals, same length as testInd.
                            % Can be vectorized code (extra-credit) 
                            % or a for loop on testInd
    
        if residuals < eps
            curInliers(:, end + 1)= j;
        end
    end
    
    curInliers = [sampleInd curInliers];           % don't forget to include the sampleInd
    
    % End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    curNInliers = length(curInliers);

    if curNInliers > bestNInliers
        bestNInliers = curNInliers;
        bestInliers = curInliers;
        E = E_sample;
    end
end

disp(['Best number of inliers: ' num2str(bestNInliers) '/' num2str(size(X1,1))]); 
