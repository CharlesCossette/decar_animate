load testData

%% Test 1 - General Motion
ani = Animation();
ani.addElement(AnimatedBox)
ani.addStaticElement(AnimatedTrace(ani.elements.AnimatedBox1));
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - Customize Color
ani = Animation();
ani.addElement(AnimatedBox)
trace = AnimatedTrace(ani.elements.AnimatedBox1);
trace.Color = [0 0 1];
ani.addStaticElement(trace);
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end
assert(all(ani.staticElements.AnimatedTrace1.Color == trace.Color))