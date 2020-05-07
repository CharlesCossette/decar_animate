% Example 1 - Minimum Working Example
addpath('..');
addpath('../lib');
% Instantiate an animation object
ani = Animation();

% Add valid objects as "elements". Add as many as you want.
ani.addElement(AnimatedBox());
ani.addElement(AnimatedCone())

% Once all elements are added, build animation to initilize all objects,
% store all the figure handles inside the ani object, and create the figure
% window. Stop the code here to see the figure windows initial state.
ani.build();

% Setup complete! Now manipulate the elements.
% Now you may control the position and orientation of the element objects 
% using the ani.update(r,C) method.
r = [[5;0;0],[0;5;5]];      % r must be a [3 x number of elements] matrix.

C_ba_box = eye(3);             
C_ba_cone = [0,0,1;1,0,0;0,1,0];
C = cat(3, C_ba_box, C_ba_cone); % C must be [3 x 3 x number of elements].
                                 % use cat(3,C1,C2,....) to concatenate in 
                                 % 3rd dimension.
                            
ani.update(r,C)

% Note: the positions and r, and the orientations in C must be in the same
% order as the order in which they were added as elements. This is why
% r(:,1) contains the box's position and r(:,2) contains the cone's
% position. 