% load rigidBodyData.mat
%% Create data
n = 10;
C = nan(3,3,n);
r = nan(3,n);
delta = nan(n,1);
for ii = 1:n
    C(:,:,ii) = getDCMrotVec([0;0;ii/10]);
    r(:,ii) = [ii; ii/2; 0];
    delta(ii) = ii/10;
end
%% 
ani = Animation();

% ani.addElement(AnimatedBox());
% box = AnimatedBox();
car = AnimatedBoxyCar(0);
car.scale = 0.5;
ani.addElement(car);
ani.addElement(AnimatedTrace(ani.elements.AnimatedBoxyCar1));

ani.build()

% axis([-5 15 -5 20 -10 10])
xlabel('x')
ylabel('y')
zlabel('z')

for lv1 = 1:size(C,3)
    view(2)
    ani.update(r(:,lv1),C(:,:,lv1))
    ani.elements.AnimatedBoxyCar1.delta = delta(lv1);
    pause(0.01)
end
