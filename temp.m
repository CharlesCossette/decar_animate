clear 
N = 10;
A=rand(N,3)*2-1;
n=sqrt(sum(A.^2,2));
A=A./repmat(n,[1 size(A,2)]);
% A = [1.0000   -0.0000   -0.0000;
%      0.0000    1.0000    0.0000;
%     -0.0000    0.0000    1.0000;
%      0.0000   -0.0000   -1.0000;
%     -0.0000   -1.0000   -0.0000;
%     -1.0000   -0.0000    0.0000]

b=ones(size(A,1),1);
V=lcon2vert(A,b);
k=convhulln(V);
 

p = plotregion(A,b);

axis equal
axis vis3d
grid on
% %axis off
h=camlight(0,90);
%p.EdgeColor = 'none'
h(2)=camlight(0,-17);
h(3)=camlight(107,-17);
h(4)=camlight(214,-17);
set(h(1),'color',[1 0 0]);
set(h(2),'color',[0 1 0]);
set(h(3),'color',[0 0 1]);
set(h(4),'color',[1 1 0]);
material metal
% for x=0:5:720
%     view(x,0)
%     drawnow
% end