function [vanishing_pt, top_pt, bottom_pt] = compute_ref_line_segment(ref, ll, lr, ur, ul)
% compute_ref_line_segment
%
%  This function finds the end points of the line segment
%   where the ref is located on the field. The results will
%   be used to plot the virtual line onto the field.
%
%  Arguments
%   ref - point of ref on the field
%   ll - lower left point of rectangle in frame
%   lr - lower right point of rectangle in frame
%   ur - upper right point of rectangle in frame
%   ul - upper left point of rectangle in frame
%
%  Returns
%   vanishing_pt - scene vanishing point
%   top_pt - top of ref's line segment
%   bottom_pt - bottom of ref's line segment

vanishing_pt = line_intersection(line_from_pts(ll,ul),line_from_pts(lr,ur));
top_pt  = line_intersection(line_from_pts(ref,vanishing_pt),line_from_pts(ur,ul));
bottom_pt = line_intersection(line_from_pts(ref,vanishing_pt),line_from_pts(lr,ll));
end
