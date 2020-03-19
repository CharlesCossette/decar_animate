
%% Test 1 - General Motion
load testData
ani = Animation();
ani.addElement(AnimatedSphere());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - Change face color and alpha on-the-fly
load testData
ani = Animation();
ani.addElement(AnimatedSphere());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    ani.elements.AnimatedSphere1.faceColor = [lv1/length(r) 0 0];
    ani.elements.AnimatedSphere1.faceAlpha = (length(r) - lv1)/length(r);
    pause(eps)
end

%% Test 3 - Customize mesh resolution
load testData
ani = Animation();
sph = AnimatedSphere();
sph.meshResolution = 50;
ani.addElement(sph);
ani.build()
for lv1 = 1:5:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 4 - Change dimensions, change dimensions on the fly
load testData
ani = Animation();
sph = AnimatedSphere();
sph.radius = 40;
sph.meshResolution = 20;
ani.addElement(sph);
ani.build()
axis([-20 20 -20 20 -20 20])
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    ani.elements.AnimatedSphere1.radius = lv1/length(r)*10;
    pause(eps)
end