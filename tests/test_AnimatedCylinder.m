load testData

%% Test 1 - General Motion
ani = Animation();
ani.addElement(AnimatedCylinder());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - Compatibility with trace
ani = Animation();
ani.addElement(AnimatedCylinder());
ani.addStaticElement(AnimatedTrace(ani.elements.AnimatedCylinder1));
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end