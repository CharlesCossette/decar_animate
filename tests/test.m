clear all

ani = Animation(1);


ani.addElement(AnimatedQuadcopter,8)


ani.build

%ani.update([0;0;10], C1_DCM(deg2rad(35)))
tic
for lv1 = 1:100
r = [[1;lv1;3],[-lv1;-1;-4],[1;-1;lv1],[-lv1;lv1;-4]];

r = [r, -r];
C = cat(3,C1_DCM(deg2rad(35)),C1_DCM(deg2rad(-35)),C3_DCM(deg2rad(35)),C2_DCM(deg2rad(-35)));
C = cat(3, C, C);
ani.update(r,C)


pause(eps)
end
toc
% cone = AnimatedCone();
% cone.baseRadius = 2;
% cone.meshResolution = 20;
% cone.length = 1;
% cone.plot([0;0;0],eye(3))



function C = C1_DCM(theta)

C = [1         0          0;
    0  cos(theta)  sin(theta);
    0 -sin(theta)  cos(theta)];
end

function C = C2_DCM(theta)

C = [cos(theta) 0 -sin(theta);
    0          1           0;
    sin(theta) 0  cos(theta)];
end

function C =  C3_DCM(theta)
C = [ cos(theta) sin(theta) 0;
    -sin(theta) cos(theta) 0;
    0        0    1];
end