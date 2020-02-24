load testData

%% Test 1 - General Motion
ani = Animation();
ani.addElement(AnimatedBox)
ani.addElement(AnimatedTrace(ani.elements.AnimatedBox1));
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end