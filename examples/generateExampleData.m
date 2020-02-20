%% Single Rigid body
r0 = zeros(3,1);
v0 = zeros(3,1);
C0 = eye(3);
x0 = [r0;v0;C0(:)];
tSpan = linspace(0,10,1000);
[t,x] = ode45(@RigidBodyODE,tSpan,x0);
data = getSimData(t,x,@RigidBodyODE);
r = data.r;
C = data.C;
save('./rigidBodyData','r','C')
%% Swarm - Runs two sims
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
data1 = getSimData(t,x,@(t,x) swarmODE4(t,x,k_col));


k_col = 1;
[t,x] = ode45(@(t,x) swarmODE4(t,x,k_col), tSpan, x0);
data2 = getSimData(t,x,@(t,x) swarmODE4(t,x,k_col));

r1 = data1.r;
r2 = data1.r;

save('./swarmData','r1','r2')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Auxiliary Functions
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
data.r = reshape(r_zw_a,3,[]);
data.error = reshape(e, 3, []);
data.errorNorm = norm(e);
end


function [x_dot,data] = RigidBodyODE(t,x)
    r_zw_a = x(1:3);
    v_zw_a = x(4:6);
    C_ba = reshape(x(7:15),3,3);

    om_ba_b = [0.2;0.5;-0.1];
    a_zwa_b = [0;0.4;0];
    
    C_ba_dot = -CROSS_M(om_ba_b)*C_ba;
    v_zw_a_dot = C_ba.'*a_zwa_b;
    x_dot = [v_zw_a;v_zw_a_dot;C_ba_dot(:)];
    data.r = r_zw_a;
    data.C = C_ba;
end

function [output] = CROSS_M(X)
% Generates a skew-symmetric matrix such that U X V = CROSS_M(U)*V
if length(X) ~= 3
    error('The input must be a vector of length 3.')
end

x1 = X(1);
x2 = X(2);
x3 = X(3);

output = [  0     -x3     x2;
           x3       0    -x1;
          -x2      x1      0];
end


function data = getSimData(t,x,simFunc)
    % This function goes through your ODE again and extracts and
    % accumulates the second "data" argument.
    
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
