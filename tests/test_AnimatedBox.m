

%% Test 1 - General Motion
load testData
ani = Animation();
ani.addElement(AnimatedBox());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - Customize face color
load testData
ani = Animation();
box = AnimatedBox();
box.faceColor = [1 0 0];
ani.addElement(box);
ani.build()

assert(all(ani.elements.AnimatedBox1.figureHandle.FaceColor == box.faceColor));

%% Test 3 - Customize edge color
load testData
ani = Animation();
box = AnimatedBox();
box.edgeColor = [1 0 0];
ani.addElement(box);
ani.build()

assert(all(ani.elements.AnimatedBox1.figureHandle.EdgeColor == box.edgeColor));

%% Test 4 - Compatibility with trace
load testData
ani = Animation();
box = AnimatedBox();
box.faceColor = [0 1 0];
ani.addElement(box);
ani.addElement(AnimatedTrace(ani.elements.AnimatedBox1));
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 5 - Change Color on-the-fly
load testData
ani = Animation();
ani.addElement(AnimatedBox());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    ani.elements.AnimatedBox1.faceColor = [lv1/length(r) 0 0];
    pause(eps)
end

