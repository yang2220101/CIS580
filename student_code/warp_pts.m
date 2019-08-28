function [ warped_pts ] = warp_pts( video_pts, logo_pts, sample_pts)
% warp_pts computes the homography that warps the points inside
% video_pts to those inside logo_pts. It then uses this
% homography to warp the points in sample_pts to points in the logo
% image
% Inputs:
%     video_pts: a 2x4 matrix of (x,y) coordinates of corners in the
%         video frame
%     logo_pts: a 2x4 matrix of (x,y) coordinates of corners in
%         the logo image
%     sample_pts: a 2xn matrix of (x,y) coordinates of points in the video
%         video that need to be warped to corresponding points in the
%         logo image
% Outputs:
%     warped_pts: a 2xn matrix of (x,y) coordinates of points obtained
%         after warping the sample_pts
% Written for the University of Pennsylvania's Robotics:Perception course

% Complete est_homography first!
[ H ] = est_homography(video_pts, logo_pts);

% YOUR CODE HERE

%to get the number of columns of sample_pts
[~,m] = size(sample_pts);
% initialize warped_pts
warped_pts = zeros(2,m);
% each time calculating one point for warped_pts
for i = 1:m
sample_pts1 = [sample_pts(:,i);1];
H_ = H * sample_pts1;
x = H_(1,1) / H_(3,1);
y = H_(2,1) / H_(3,1);
a = [x;y];
warped_pts(:,i) = a;
end
end

