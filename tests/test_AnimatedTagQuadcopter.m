

%% Test 1 - General Motion w 1 Tag
load testData
ani = Animation();
ani.addElement(AnimatedTagQuad());
ani.build()
for lv1 = 1:5:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 2 - General Motion w 2 Tags
load testData
ani = Animation();
ani.addElement(Animated2TagQuad());
ani.build()
for lv1 = 1:5:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 3 - General Motion with copies
load testData
ani = Animation();
ani.addElement(AnimatedTagQuad(),2);
ani.addElement(Animated2TagQuad(), 2)
ani.build()

r_group = randn(3,4)*5;

for lv1 = 1:5:length(r)
    C_group = repmat(C(:,:,lv1),1,1,4);
    ani.update(C(:,:,lv1)*r_group + r(:,lv1), C_group)
    pause(eps)
end

%% Test 3 - Test sub-elements customization w 1 Tag
load testData
ani = Animation();
quad = AnimatedTagQuad();
quad.prop1.edgeColor = [0,0,0];
ani.addElement(quad)
ani.build()

r = randn(3,4)*5;
C = repmat(eye(3),1,1,4);
ani.update(r,C);

assert(all(ani.elements.AnimatedTagQuad1.prop1.edgeColor == quad.prop1.edgeColor));

%% Test 3 - Test sub-elements customization w 2 Tags
load testData
ani = Animation();
quad = Animated2TagQuad();
quad.prop1.edgeColor = [0,0,0];
ani.addElement(quad)
ani.build()

r = randn(3,4)*5;
C = repmat(eye(3),1,1,4);
ani.update(r,C);

assert(all(ani.elements.Animated2TagQuad1.prop1.edgeColor == quad.prop1.edgeColor));

%% Test 4 - Test copy with sub elements customization
load testData
ani = Animation();
quad = AnimatedTagQuad();
quad.prop1.edgeColor = [0,0,0];
ani.addElement(quad,2)
quad = Animated2TagQuad();
quad.prop1.edgeColor = [0,0,0];
ani.addElement(quad,2)
ani.build()

rng(1)
r = randn(3,4)*5;
C = repmat(eye(3),1,1,4);
ani.update(r,C);

assert(all(ani.elements.AnimatedTagQuad1.prop1.edgeColor == quad.prop1.edgeColor));
assert(all(ani.elements.AnimatedTagQuad2.prop1.edgeColor == quad.prop1.edgeColor));
assert(all(ani.elements.Animated2TagQuad1.prop1.edgeColor == quad.prop1.edgeColor));
assert(all(ani.elements.Animated2TagQuad2.prop1.edgeColor == quad.prop1.edgeColor));

%% Test 5 - General motion with scale customization in a loop w 1 Tag
load testData
rng(1)
ani  = Animation();
quad = AnimatedTagQuad();
ani.addElement(quad)
ani.build()
axis([-90 90 -90 90 -90 90])
for lv1 = 1:5:length(r)
    oldScale = ani.elements.AnimatedTagQuad1.scale;
    ani.elements.AnimatedTagQuad1.scale = oldScale + rand;
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 5 - General motion with scale customization in a loop w 2 Tags
load testData
rng(1)
ani  = Animation();
quad = Animated2TagQuad();
ani.addElement(quad)
ani.build()
axis([-90 90 -90 90 -90 90])
for lv1 = 1:5:length(r)
    oldScale = ani.elements.Animated2TagQuad1.scale;
    ani.elements.Animated2TagQuad1.scale = oldScale + rand;
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 6 - Test copy with scale customization
load testData
ani = Animation();
quad = AnimatedTagQuad();
quad.scale = 10;
ani.addElement(quad,2)
quad = Animated2TagQuad();
quad.scale = 10;
ani.addElement(quad,2)
ani.build()

r = randn(3,4)*5;
C = repmat(eye(3),1,1,4);
ani.update(r,C);
assert(all(ani.elements.AnimatedTagQuad1.scale == quad.scale));
assert(all(ani.elements.AnimatedTagQuad2.scale == quad.scale));
assert(all(ani.elements.Animated2TagQuad1.scale == quad.scale));
assert(all(ani.elements.Animated2TagQuad2.scale == quad.scale));

%% Test 7 - General copy with scale customization
load testData
ani = Animation();
quad = AnimatedTagQuad();
quad.scale = 10;
ani.addElement(quad,2)
quad = Animated2TagQuad();
quad.scale = 10;
ani.addElement(quad,2)
ani.build()

r_group = randn(3,4)*5;

for lv1 = 1:5:length(r)
    C_group = repmat(C(:,:,lv1),1,1,4);
    ani.update(C(:,:,lv1)*r_group + r(:,lv1), C_group)
    pause(eps)
end

%% Test 8 - General motion with sub-element property customization in a loop w 1 Tag
load testData
ani  = Animation();
quad = AnimatedTagQuad();
quad.tagArm.faceAlpha = 1;
quad.tagArm.edgeColor = 'none';
ani.addElement(quad);
ani.build()
for lv1 = 1:5:length(r)
    ani.elements.AnimatedTagQuad1.tagArm.faceColor = [lv1/length(r) 0 0];
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end


%% Test 8 - General motion with sub-element property customization in a loop w 2 Tags
load testData
ani  = Animation();
quad = Animated2TagQuad();
quad.tagArm1.faceAlpha = 1;
quad.tagArm1.edgeColor = 'none';
ani.addElement(quad);
ani.build()
for lv1 = 1:5:length(r)
    ani.elements.Animated2TagQuad1.tagArm1.faceColor = [lv1/length(r) 0 0];
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end
