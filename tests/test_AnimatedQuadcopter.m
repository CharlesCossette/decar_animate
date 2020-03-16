load testData

%% Test 1 - General Motion
ani = Animation();
ani.addElement(AnimatedQuadcopter());
ani.build()
for lv1 = 1:5:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - General Motion with copies
ani = Animation();
ani.addElement(AnimatedQuadcopter(),4);
ani.build()

r_group = randn(3,4)*5;

for lv1 = 1:5:length(r)
    C_group = repmat(C(:,:,lv1),1,1,4);
    ani.update(C(:,:,lv1)*r_group + r(:,lv1), C_group)
    pause(eps)
end

%% Test 3 - Test sub-elements customization
ani = Animation();
quad = AnimatedQuadcopter();
quad.prop1.edgeColor = [0,0,0];
ani.addElement(quad)
ani.build()

r = randn(3,4)*5;
C = repmat(eye(3),1,1,4);
ani.update(r,C);

assert(all(ani.elements.AnimatedQuadcopter1.prop1.edgeColor == quad.prop1.edgeColor));

%% Test 4 - Test copy with sub elements customization
ani = Animation();
quad = AnimatedQuadcopter();
quad.prop1.edgeColor = [0,0,0];
ani.addElement(quad,4)
ani.build()

r = randn(3,4)*5;
C = repmat(eye(3),1,1,4);
ani.update(r,C);

assert(all(ani.elements.AnimatedQuadcopter1.prop1.edgeColor == quad.prop1.edgeColor));
assert(all(ani.elements.AnimatedQuadcopter2.prop1.edgeColor == quad.prop1.edgeColor));
assert(all(ani.elements.AnimatedQuadcopter3.prop1.edgeColor == quad.prop1.edgeColor));
assert(all(ani.elements.AnimatedQuadcopter4.prop1.edgeColor == quad.prop1.edgeColor));

%% Test 5 - General motion with scale customization in a loop
rng(1)
ani  = Animation();
quad = AnimatedQuadcopter();
ani.addElement(quad)
ani.build()
for lv1 = 1:5:length(r)
    oldScale = ani.elements.AnimatedQuadcopter1.scale;
    ani.elements.AnimatedQuadcopter1.scale = oldScale + rand;
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 6 - Test copy with scale customization
ani = Animation();
quad = AnimatedQuadcopter();
quad.scale = 10;
ani.addElement(quad,4)
ani.build()

r = randn(3,4)*5;
C = repmat(eye(3),1,1,4);
ani.update(r,C);
assert(all(ani.elements.AnimatedQuadcopter1.scale == quad.scale));
assert(all(ani.elements.AnimatedQuadcopter2.scale == quad.scale));
assert(all(ani.elements.AnimatedQuadcopter3.scale == quad.scale));
assert(all(ani.elements.AnimatedQuadcopter4.scale == quad.scale));

%% Test 7 - General copy with scale customization
load testData
ani = Animation();
quad = AnimatedQuadcopter();
quad.scale = 10;
ani.addElement(quad,4)
ani.build()

r_group = randn(3,4)*5;

for lv1 = 1:5:length(r)
    C_group = repmat(C(:,:,lv1),1,1,4);
    ani.update(C(:,:,lv1)*r_group + r(:,lv1), C_group)
    pause(eps)
end