function drawEpipolarLines(im1,im2,U1,U2,E,K)
% Show both images, and matching points and 
% epipolars. A given point should be very
% close to (if not right on) the epipolar corresponding
% to its matching point in the other image.

% Your code goes here %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

F = (inv(K))' * E * inv(K);                       % 3 x 3 fundamental matrix

r1 = size(U1,1);
r2 = size(U2,1);
% c1 = ones(r1, 1);
% c2 = ones(r2, 1);
% U1 = [U1 c1];
% U2 = [U2 c2];
%epiLines1 = (U2 * F)' ;               % 3 x number of points, 
                           % each column contains the normal to 
                           % epi(U2) in image 1

%epiLines2 = (F * U1')' ;             
for i = 1:r2
    epi_u2(i,:) = U2(i,:) * F;

end
epiLines1 = epi_u2';
epi_u1 = zeros(size(U1,1),3);
for i = 1:r1
    epi_u1(i,:) = U1(i,:) * F';

end
epiLines2 = epi_u1';
% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure()
subplot(1,2,1)
imshow(im1)
drawLines(epiLines1,size(im1,1),size(im1,2));
plot(U1(:,1),U1(:,2),'bs');

subplot(1,2,2)
imshow(im2)
drawLines(epiLines2,size(im2,1),size(im2,2));
plot(U2(:,1),U2(:,2),'bs');

