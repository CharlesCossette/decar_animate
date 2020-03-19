
%% Test 1 - General Motion
load testData
ani = Animation();
ani.addElement(AnimatedPolyhedron());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end
