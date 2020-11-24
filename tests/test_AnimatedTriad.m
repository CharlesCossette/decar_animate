

%% Test 1 - General Motion
load testData
ani = Animation();
ani.addElement(AnimatedTriad());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test  - Compatibility with trace
load testData
ani = Animation();
triad = AnimatedTriad();
ani.addElement(triad);
ani.addElement(AnimatedTrace(ani.elements.AnimatedTriad1));
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end



