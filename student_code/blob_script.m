%% 2D Blob Detection

% IMPORTANT: change the path to MinMaxFilterFolder and the image
% to the right location in your code folder
addpath('MinMaxFilterFolder');
impath = 'ball.jpg';

% Load the image
im = double(imread(impath));

% Resize and keep the green channel (where sunflowers seem to be salient)
im = im(:,:,2);

% Resize image
im = imresize(im,0.5);
im = im - min(im(:));

% Scale space parameters
n_scales = 30;
sigma = 3;
k = sqrt(2);

% Create blurred versions of the image
scales = zeros([size(im) n_scales+1]);

for i=1:n_scales+1
    sigma_i = sigma* k^(i-1);
    fSize = 10*sigma_i;
    % Your code starts here %%%%%%%%%%%%%%%%%%%%
    % convolve with gaussians to build the scale space
    g_i = gaussian1d(sigma_i, fSize);
    im1 = conv2(im,g_i,'same');
    im1 = conv2(im1,g_i','same');
    
    
    scales(:,:,i) = im1;
    % End of your code %%%%%%%%%%%%%%%%%%%%%%%%%
end

% Difference of Gaussians
dog = scales(:,:,2:n_scales+1) - scales(:,:,1:n_scales);

% Look for local maxima in 3x3x3 boxes
dog_max = minmaxfilt(dog,3,'max','same');
[ymax xmax smax] = ind2sub(size(dog),find(dog==dog_max));

% Filter out maxima near the borders
indkeep = find(ymax>10 & ymax < size(dog,1)-10 &...
               xmax>10 & xmax < size(dog,2)-10 &...
               smax>1 & smax<size(dog,3));
ymax = ymax(indkeep);
xmax = xmax(indkeep);
smax = smax(indkeep);

% Only keep detections above a certain threshold
% Your code starts here %%%%%%%%%%%%%%%%%%%%%%%
maxi = max(max(max(dog_max)));
rem = zeros(size(xmax));
for i = 1:length(xmax)
    if dog(ymax(i),xmax(i),smax(i)) < 0.5 * maxi
        rem(i) = 1;
    end
end
% Keep only local maxima that have a response above
% 50% of the maximum response over the whole 3D scale
% space
del = find(rem == 1);
ymax(del) = [];
xmax(del) = [];
smax(del) = [];
            

% End of your code %%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Show image and detections
figure();
imagesc(im); colormap(gray);
hold on;
plot(xmax,ymax,'bs');
% Plot all detections as circles
for i=1:length(xmax)
    % Compute radius of the blob as a function of sigma and k
    % Your code goes here %%%%%%%%%%%%%%%%%%%%%%
	r = sqrt(2) * sigma * k ^ (smax(i) - 0.25);

    % End of your code %%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Plot circles, using Matlab's rectangle function
    % (type 'help rectangle' if you are not convinced)
    rectangle('Position',[xmax(i)-r ymax(i)-r 2*r 2*r],...
              'Curvature',[1 1],...
              'LineWidth',2,...
              'EdgeColor','b');
end
axis equal
axis tight