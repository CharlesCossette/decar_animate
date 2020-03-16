%% Test 1 - General Motion
load testData
ani = Animation();
ani.addElement(AnimatedCone());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - Test Edge Color customization
load testData
ani = Animation();
cone1 = AnimatedCone();
cone2 = AnimatedCone();
cone1.edgeColor = [0;0;0];
cone2.edgeColor = [0.8;0.8;0.8];
ani.addElement(cone1);
ani.addElement(cone2);
ani.build

r = randn(3,2)*3;
C = cat(3,eye(3),eye(3));
ani.update(r,C);
assert(all(ani.elements.AnimatedCone1.edgeColor == cone1.edgeColor))
assert(all(ani.elements.AnimatedCone1.edgeColor == cone1.edgeColor))

%% Test 3 - Test tip radius customization
load testData
ani = Animation();
cone = AnimatedCone();
cone.tipRadius = 0.3;
ani.addElement(cone);
ani.build();
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 5 - Change face color and alpha on-the-fly
load testData
ani = Animation();
ani.addElement(AnimatedCone());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    ani.elements.AnimatedCone1.faceColor = [lv1/length(r) 0 0];
    ani.elements.AnimatedCone1.faceAlpha = (length(r) - lv1)/length(r);
    pause(eps)
end

