clearvars
%close all

% Initial conditions
r_z1w_a = [20;-20;10];
r_z2w_a = [20;20;10];
r_z3w_a = [20;20;-5];
r_z4w_a = [-20;-20;-5];
x0      = [r_z1w_a;r_z2w_a;r_z3w_a;r_z4w_a];

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulate 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tSpan = linspace(0,10,16*10);
k_col = 0;
[t,x] = ode45(@(t,x) swarmODE4(t,x,k_col), tSpan, x0);
data1 = PostProcessing(t,x,@(t,x) swarmODE4(t,x,k_col));


k_col = 1;
[t,x] = ode45(@(t,x) swarmODE4(t,x,k_col), tSpan, x0);
data2 = PostProcessing(t,x,@(t,x) swarmODE4(t,x,k_col));

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build Animation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)

subplot(1,2,1)
ani1 = Animation();
ani1.addElement(AnimatedQuadcopter(),4)
ani1.build
axis([-21 21 -21 21 -10 10])
grid on
title('Without formation regulation')

subplot(1,2,2)
ani2 = Animation();
ani2.addElement(AnimatedQuadcopter(),4)
ani2.build
axis([-21 21 -21 21 -10 10])
grid on
title('With formation regulation')

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Play and/or record animation
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
recording = false;
if recording == true
    vid = VideoWriter('animation.mp4');
    vid.FrameRate = 16;
    vid.Quality = 100;
    open(vid);
end

for lv1 = 1:length(t)/2
    r1 = reshape(data1.state(lv1,:),3,[]);
    r2 = reshape(data2.state(lv1,:),3,[]);
    C = cat(3,eye(3), eye(3), eye(3), eye(3));
    
    ani1.update(r1,C)
    ani2.update(r2,C)
    pause(eps)
    
    if recording == true
       frame = getframe(gcf);
       writeVideo(vid,frame);
    end
end

if recording == true
    close(vid);
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Functions
function [x_dot, data] = swarmODE4(t,x,k_col)
% Single integrator dynamics ODE with simple proportional control law

% Desired positions
r_d1w_a = [10;10;0];
r_d2w_a = [10;-10;0];
r_d3w_a = [-10;10;0];
r_d4w_a = [-10;-10;0];
r_dw_a = [r_d1w_a;r_d2w_a;r_d3w_a;r_d4w_a];

% Actual positions
r_zw_a = x;

% Error
e = r_dw_a - r_zw_a;

% Laplacian of fully connected graph
L = -1*ones(4,4) + 4*eye(4);

% Control law
k_p = 1;
%k_col = 1;
u = k_p*e + k_col*kron(L,eye(3))*e;
x_dot = u; % Single integrator dynamics

% Data logging
data.error = reshape(e, 3, []);
data.errorNorm = norm(e);
end


function data = PostProcessing(t,x,simFunc)

    
   data = [];
   data.t = t;
   data.state = x;
   x_dot = zeros(size(x))';
   for lv1 = 1:size(x,1)
       [x_dot(:,lv1), sol_data] = simFunc(t(lv1), x(lv1,:)');
       dataNames = fieldnames(sol_data);
       for lv2 = 1:numel(dataNames)
           if isfield(data, dataNames{lv2})
              N = ndims(sol_data.(dataNames{lv2}));      
              data.(dataNames{lv2}) = cat(N+1, data.(dataNames{lv2}), sol_data.(dataNames{lv2}));
           else
              data.(dataNames{lv2}) = [sol_data.(dataNames{lv2})];
           end
       end 
   end
  
   dataNames = fieldnames(data);
   for lv1 = 1:numel(dataNames)
       data.(dataNames{lv1}) = squeeze(data.(dataNames{lv1}));
   end
end
