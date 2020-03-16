
%% Test 1 - General Motion
load testData
ani = Animation();
ani.addElement(AnimatedBox)
ani.addElement(AnimatedTrace(ani.elements.AnimatedBox1));
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - General Motion with customized properties
load testData
ani = Animation();
ani.addElement(AnimatedBox)
tr = AnimatedTrace(ani.elements.AnimatedBox1);
tr.color = 'b';
tr.lineWidth = 10;
ani.addElement(tr);
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end