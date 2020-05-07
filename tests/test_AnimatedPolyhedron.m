
%% Test 1 - General Motion
load testData
ani = Animation();
ani.addElement(AnimatedPolyhedron());
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end


%% Test 2 - Custom Polyhedron
load testData
ani = Animation();
poly = AnimatedPolyhedron();
poly.A = [-0.7170    0.6151   -0.3280;
        -  0.8559   -0.1084    0.5056;
           0.4605   -0.8678   -0.1864;
          -0.5902   -0.3881    0.7079;
          -0.2116   -0.2780    0.9370;
           0.5849   -0.7156   -0.3819;
          -0.3211   -0.6909   -0.6477;
           0.4788    0.6517    0.5883;
          -0.2256   -0.1501    0.9626;
           0.3967    0.8387   -0.3730];
poly.b = ones(size(poly.A,1),1);
ani.addElement(poly);
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1), C(:,:,lv1))
    pause(eps)
end

%% Test 3 - Custom Polyhedron with changing color
load testData
ani = Animation();
poly = AnimatedPolyhedron();
poly.A = [-0.7170    0.6151   -0.3280;
        -  0.8559   -0.1084    0.5056;
           0.4605   -0.8678   -0.1864;
          -0.5902   -0.3881    0.7079;
          -0.2116   -0.2780    0.9370;
           0.5849   -0.7156   -0.3819;
          -0.3211   -0.6909   -0.6477;
           0.4788    0.6517    0.5883;
          -0.2256   -0.1501    0.9626;
           0.3967    0.8387   -0.3730];
poly.b = ones(size(poly.A,1),1);
ani.addElement(poly);
ani.build()
for lv1 = 1:2:length(r)
    ani.update(r(:,lv1),C(:,:,lv1))
    ani.elements.AnimatedPolyhedron1.faceColor = [0 0 lv1/length(r)];
    pause(eps)
end

%% Test 4 - Multiple polyhedron with hold on
load testData
ani1 = Animation();
poly = AnimatedPolyhedron();
poly.A = [-0.7170    0.6151   -0.3280;
        -  0.8559   -0.1084    0.5056;
           0.4605   -0.8678   -0.1864;
          -0.5902   -0.3881    0.7079;
          -0.2116   -0.2780    0.9370;
           0.5849   -0.7156   -0.3819;
          -0.3211   -0.6909   -0.6477;
           0.4788    0.6517    0.5883;
          -0.2256   -0.1501    0.9626;
           0.3967    0.8387   -0.3730];
poly.b = ones(size(poly.A,1),1);
ani1.addElement(poly);
ani1.build()

hold on
poly = AnimatedPolyhedron();
poly.A = [-0.7170    0.6151   -0.3280;
        -  0.8559   -0.1084    0.5056;
           0.4605   -0.8678   -0.1864;
          -0.5902   -0.3881    0.7079;
          -0.2116   -0.2780    0.9370;
           0.5849   -0.7156   -0.3819;
          -0.3211   -0.6909   -0.6477;
           0.4788    0.6517    0.5883;
          -0.2256   -0.1501    0.9626;
           0.3967    0.8387   -0.3730];
poly.b = ones(size(poly.A,1),1);
ani2 = Animation();
ani2.addElement(poly);
ani2.build();
hold off

ani1.update(r(:,5),C(:,:,200))
ani2.update(r(:,100),eye(3))

assert(length(findall(gca)) == 3)

%% Test 4 - Multiple polyhedron with hold off
load testData
ani1 = Animation();
poly = AnimatedPolyhedron();
poly.A = [-0.7170    0.6151   -0.3280;
        -  0.8559   -0.1084    0.5056;
           0.4605   -0.8678   -0.1864;
          -0.5902   -0.3881    0.7079;
          -0.2116   -0.2780    0.9370;
           0.5849   -0.7156   -0.3819;
          -0.3211   -0.6909   -0.6477;
           0.4788    0.6517    0.5883;
          -0.2256   -0.1501    0.9626;
           0.3967    0.8387   -0.3730];
poly.b = ones(size(poly.A,1),1);
ani1.addElement(poly);
ani1.build()

hold off
poly = AnimatedPolyhedron();
poly.A = [-0.7170    0.6151   -0.3280;
        -  0.8559   -0.1084    0.5056;
           0.4605   -0.8678   -0.1864;
          -0.5902   -0.3881    0.7079;
          -0.2116   -0.2780    0.9370;
           0.5849   -0.7156   -0.3819;
          -0.3211   -0.6909   -0.6477;
           0.4788    0.6517    0.5883;
          -0.2256   -0.1501    0.9626;
           0.3967    0.8387   -0.3730];
poly.b = ones(size(poly.A,1),1);
ani2 = Animation();
ani2.addElement(poly);
ani2.build();
hold off

assert(length(findall(gca)) == 2)
