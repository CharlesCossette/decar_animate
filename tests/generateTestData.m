%% Single Rigid body

% Simulate Poisson's equation for a reasonable DCM
C0 = eye(3);
x0 = C0(:);
tSpan = linspace(0,10,1000);
[t,x] = ode45(@RigidBodyODE,tSpan,x0);
data = getSimData(t,x,@RigidBodyODE);

% Position travels along a circle
r = [cos(tSpan/tSpan(end)*2*pi);sin(tSpan/tSpan(end)*2*pi);sin(tSpan/tSpan(end)*pi)]*5;
C = data.C;
save('./tests/testData','C','r')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [x_dot,data] = RigidBodyODE(t,x)
    C_ba = reshape(x(1:9),3,3);

    om_ba_b = [0.2;0.5;-0.1];
    
    C_ba_dot = -CROSS_M(om_ba_b)*C_ba;
    x_dot = C_ba_dot(:);
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
