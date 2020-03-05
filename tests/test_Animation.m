
%% Test 1 - Test element customization
ani = Animation();
box = AnimatedBox();
box.width = 3;
box.height = 10;
box.length = 2;
ani.addElement(box)
ani.build()

assert(ani.elements.AnimatedBox1.width == box.width)
assert(ani.elements.AnimatedBox1.length == box.length)
assert(ani.elements.AnimatedBox1.height == box.height)

%% Test 2 - Test copy
ani = Animation();
ani.addElement(AnimatedBox(),4)
ani.build;

r = randn(3,4)*5;
C = repmat(eye(3),1,1,4);
ani.update(r,C);

assert(isfield(ani.elements,'AnimatedBox1'))
assert(isfield(ani.elements,'AnimatedBox2'))
assert(isfield(ani.elements,'AnimatedBox3'))
assert(isfield(ani.elements,'AnimatedBox4'))

%% Test 3 - Test copy with customization
ani = Animation();
box = AnimatedBox();
box.width = 3;
box.height = 10;
box.length = 2;
ani.addElement(box,4)
ani.build()

r = randn(3,4)*5;
C = repmat(eye(3),1,1,4);
ani.update(r,C);

assert(ani.elements.AnimatedBox2.width == box.width)
assert(ani.elements.AnimatedBox2.length == box.length)
assert(ani.elements.AnimatedBox2.height == box.height)
assert(ani.elements.AnimatedBox3.width == box.width)
assert(ani.elements.AnimatedBox3.length == box.length)
assert(ani.elements.AnimatedBox3.height == box.height)
assert(ani.elements.AnimatedBox4.width == box.width)
assert(ani.elements.AnimatedBox4.length == box.length)
assert(ani.elements.AnimatedBox4.height == box.height)

