% Example 1 - Minimum Working Example

% Instantiate an animation object
ani = Animation();

% Add valid objects as "elements". Add as many as you want.
ani.addElement(AnimatedBox());
ani.addElement(AnimatedCone())

% Generates all figure handles.
ani.build();

% Setup complete! Now manipulate the elements.
r = [[5;0;0],[0;5;5]];      % r must be a [3 x number of elements] matrix.

C_ba_box = eye(3);             
C_ba_cone = [0,0,1;1,0,0;0,1,0];

C = cat(3, C_ba_box, C_ba_cone); % C must be [3 x 3 x number of elements].
                                 % use cat(3,C1,C2,....) to concatenate in 
                                 % 3rd dimension.
                            
ani.update(r,C)

