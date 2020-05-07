
%% Test 1 - General Motion
load testData
ani = Animation();
ani.addElement(AnimatedCylinder());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - Change face color and alpha on-the-fly
load testData
ani = Animation();
ani.addElement(AnimatedCylinder());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    ani.elements.AnimatedCylinder1.faceColor = [lv1/length(r) 0 0];
    ani.elements.AnimatedCylinder1.faceAlpha = (length(r) - lv1)/length(r);
    pause(eps)
end

%% Test 3 - Custom Radius profile
load testData
ani = Animation();
cyl = AnimatedCylinder();
cyl.radius = [ 0.5 1 2  3 0.5];
ani.addElement(cyl);
ani.build()
for lv1 = 1:5:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 4 - Capped cylinder
load testData
ani = Animation();
cyl = AnimatedCylinder();
cyl.radius = ones(40,1);
cyl.radius(1) = 0;
cyl.radius(end) = 0;
ani.addElement(cyl);
ani.build()
for lv1 = 1:5:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end