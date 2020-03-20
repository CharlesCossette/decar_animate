function p = plotregion(A,b)
% The function plotregion plots closed convex regions in 2D/3D. The region
% is formed by the matrix A and the vectors lb and ub such that Ax<=b
%
% Inputs:
% ----------
% A - matrix
% b - vector
%
% Corresponding to the inequality set A*x <= b
%
% Written by Per Bergström 2006-01-16
if nargin<2
    error('Too few arguements for plotregion');
end

b = -b; % Since this stupid code works for Ax >= b

% Get number of inequalities m and size of space n.
[m,n]=size(A);

% Some visual properties
eq=[];
X=[];
warning off

for lv1=1:(m-2)
    for lv2=(lv1+1):(m-1)
        for lv3=(lv2+1):m
            try
                x=A([lv1 lv2 lv3],:)\b([lv1 lv2 lv3]);
                if and(min((A*x-b))>-1e-6,min((A*x-b))<Inf)
                    X=[X,x];
                    eq=[eq,[lv1 lv2 lv3]'];
                end
            catch
            end
        end
    end
end

V = [];
F = {};
for lv1=1:m
    
    [~,colInd2]=find(eq==lv1);
    
    if ~isempty(colInd2)
        xm = mean(X(:,colInd2),2);
        Xdiff = X(:,colInd2);
        for lv2=1:length(colInd2)
            Xdiff(:,lv2) = Xdiff(:,lv2) - xm;
            Xdiff(:,lv2) = Xdiff(:,lv2)/norm(Xdiff(:,lv2));
        end
        costhe = zeros(length(colInd2),1);
        
        for lv2=1:length(colInd2)
            costhe(lv2) = Xdiff(:,1).'*Xdiff(:,lv2);
        end
        
        [~,ind]=min(abs(costhe));
        ref2 = Xdiff(:,ind(1))-(Xdiff(:,ind(1))'*Xdiff(:,1))*Xdiff(:,1);
        ref2 = ref2'/norm(ref2);
        
        for lv2=1:length(colInd2)
            if ref2 * Xdiff(:,lv2)<0
                costhe(lv2) = -2 - costhe(lv2);
            end
        end
        [~,ind3] = sort(costhe);
        
        V_k = [X(1,colInd2(ind3)).',X(2,colInd2(ind3)).',X(3,colInd2(ind3)).'];
        F{lv1} = [1:size(V_k,1)]+size(V,1);
        V = [V;V_k];
    end
end
F = padcat(F{:});
if n == 3
    view(3)
else
    view(2)
end
p = patch('Vertices',V, 'Faces',F,'FaceColor','r');
end


