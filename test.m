clear all

ani = Animation(1);

ani.addElement(AnimatedCylinder)
ani.addElement(AnimatedBox)


ani.build

for lv1 = 1:100
r = [[1;lv1;3],[-lv1;-1;-4]];
C = cat(3,eye(3),eye(3))

ani.update(r,C)

axis([-inf inf -inf inf -inf inf])
pause(0.001)
end

% cone = AnimatedCone();
% cone.baseRadius = 2;
% cone.meshResolution = 20;
% cone.length = 1;
% cone.plot([0;0;0],eye(3))