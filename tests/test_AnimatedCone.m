load testData

%% Test 1 - General Motion
ani = Animation();
ani.addElement(AnimatedCone());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - Test Edge Color customization
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
