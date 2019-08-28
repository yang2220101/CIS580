function [ H ] = est_homography(video_pts, logo_pts)
% est_homography estimates the homography to transform each of the
% video_pts into the logo_pts
% Inputs:
%     video_pts: a 2x4 matrix of corner points in the video
%     logo_pts: a 2x4 matrix of logo points that correspond to video_pts
% Outputs:
%     H: a 3x3 homography matrix such that logo_pts ~ H*video_pts
% Written for the University of Pennsylvania's Robotics:Perception course

% YOUR CODE HERE
H = [];
% initialize A
A = zeros(8,9);
% complete matrix A according to Appendix A
A(1,:) = [-video_pts(1,1),-video_pts(2,1),-1,0,0,0,video_pts(1,1) * logo_pts(1,1),video_pts(2,1) * logo_pts(1,1),logo_pts(1,1)];
A(2,:) = [0,0,0,-video_pts(1,1),-video_pts(2,1),-1,video_pts(1,1) * logo_pts(2,1),video_pts(2,1) * logo_pts(2,1),logo_pts(2,1)];
A(3,:) = [-video_pts(1,2),-video_pts(2,2),-1,0,0,0,video_pts(1,2) * logo_pts(1,2),video_pts(2,2) * logo_pts(1,2),logo_pts(1,2)];
A(4,:) = [0,0,0,-video_pts(1,2),-video_pts(2,2),-1,video_pts(1,2) * logo_pts(2,2),video_pts(2,2) * logo_pts(2,2),logo_pts(2,2)];
A(5,:) = [-video_pts(1,3),-video_pts(2,3),-1,0,0,0,video_pts(1,3) * logo_pts(1,3),video_pts(2,3) * logo_pts(1,3),logo_pts(1,3)];
A(6,:) = [0,0,0,-video_pts(1,3),-video_pts(2,3),-1,video_pts(1,3) * logo_pts(2,3),video_pts(2,3) * logo_pts(2,3),logo_pts(2,3)];
A(7,:) = [-video_pts(1,4),-video_pts(2,4),-1,0,0,0,video_pts(1,4) * logo_pts(1,4),video_pts(2,4) * logo_pts(1,4),logo_pts(1,4)];
A(8,:) = [0,0,0,-video_pts(1,4),-video_pts(2,4),-1,video_pts(1,4) * logo_pts(2,4),video_pts(2,4) * logo_pts(2,4),logo_pts(2,4)];
% use SVD to get h so that Ah is small
[U,S,V] = svd(A);
h = V(:,9);
% construct the 3x3 homography matrix by reshaping the 9x1 h vector.
H = reshape(h,3,3);
H = transpose(H);
end

