
%% Test 1 - General Motion
load testData
ani = Animation();
ani.addElement(AnimatedEllipsoid());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - Change face color and alpha on-the-fly
load testData
ani = Animation();
ani.addElement(AnimatedEllipsoid());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    ani.elements.AnimatedEllipsoid1.faceColor = [lv1/length(r) 0 0];
    ani.elements.AnimatedEllipsoid1.faceAlpha = (length(r) - lv1)/length(r);
    pause(eps)
end

%% Test 3 - Customize mesh resolution
load testData
ani = Animation();
ellp = AnimatedEllipsoid();
ellp.meshResolution = 50;
ani.addElement(ellp);
ani.build()
for lv1 = 1:5:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 4 - Change dimensions, change dimensions on the fly
load testData
ani = Animation();
ellp = AnimatedEllipsoid();
ellp.xRadius = 5;
ellp.yRadius = 5;
ellp.zRadius = 1;
ellp.meshResolution = 20;
ani.addElement(ellp);
ani.build()
for lv1 = 1:4:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    ani.elements.AnimatedEllipsoid1.zRadius = lv1/length(r)*5;
    pause(eps)
end