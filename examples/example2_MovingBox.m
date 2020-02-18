load rigidBodyData.mat

ani = Animation();

ani.addElement(AnimatedBox());

ani.build()

axis([-5 15 -5 20 -10 10])
xlabel('x')
ylabel('y')
zlabel('z')

for lv1 = 1:size(C,3)
    ani.update(r(:,lv1),C(:,:,lv1))
    pause(0.001)
end
