function g = gaussian2d(Sigma, len)
% GAUSSIAN2D - make discrete normalized centered 2D Gaussian
%
% Syntax: g = gaussian2d(Sigma, len);
%
% Output is symmetric with unit sampling period.
% (0,0) is sampled only when len is odd.
%
% Inputs:
%   Sigma: 2x2 covariance matrix
%   len: output is len x len.
%

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%
point = linspace(-(len-1)/2,(len-1)/2,len);
% [X,Y] = meshgrid(point,point);


% p = mvnpdf([X(:) Y(:)],[0,0],Sigma);
for i = 1:len
    for j = 1:len
        p(i,j) = (2*pi*sqrt(det(Sigma))).^(-1) * exp(-0.5 * [point(1,i) point(1,j)] /(Sigma) * [point(1,i) point(1,j)]');
    end
end
% g = reshape(p,len,len);
g = p'/sum(p(:));
% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%