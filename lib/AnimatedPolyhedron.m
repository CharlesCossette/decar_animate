classdef AnimatedPolyhedron < handle
    %ANIMATEDBOX  Creates a CONVEX polyhedron by specifiying either the
    %vertices or the A,b matrices corresponding to inequality set A*r <= b.
    properties
        % Position and attitude
        r
        C
        
        % Visual properties
        length
        width
        height
        vertices
        A
        b
        faceColor
        edgeColor
        faceAlpha
        edgeAlpha
        
        % Working variables
        polyPoints
        figureHandle
        
    end
    
    methods
        function self = AnimatedPolyhedron()
            % Constructor - default properties
            self.length = 1;
            self.width = 1;
            self.height = 1;
            self.faceColor = [0.5 0.5 0.5];
            self.edgeColor = [0 0 0];
            self.faceAlpha = 0.5;
            self.edgeAlpha = 1;
        end
        
        function plot(self,r_zw_a,C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % Generate nominal points corresponding to dimensions;
            self.updatePoints()
            
            % Reshape intro matrices compatible for surf(X,Y,Z) function
            X = reshape(self.polyPoints(1,:),3,[]);
            Y = reshape(self.polyPoints(2,:),3,[]);
            Z = reshape(self.polyPoints(3,:),3,[]);
            
            % Create plot
            self.figureHandle = patch(X, Y, Z,'r');
            
            % Rotate and translate using update()
            self.update(r_zw_a, C_ba)
        end
        
        
        function update(self, r_zw_a, C_ba)
            % Update geometry
            self.updatePoints()
            
            % Rotate and translate
            boxRot = C_ba.'*self.polyPoints + r_zw_a;
            
            % Reshape into matrices compatible for surf(X,Y,Z) function
            xRot = reshape(boxRot(1,:),3,[]);
            yRot = reshape(boxRot(2,:),3,[]);
            zRot = reshape(boxRot(3,:),3,[]);
            
            % Update data
            self.figureHandle.XData = xRot;
            self.figureHandle.YData = yRot;
            self.figureHandle.ZData = zRot;
            self.figureHandle.FaceColor = self.faceColor;
            self.figureHandle.FaceAlpha = self.faceAlpha;
            self.figureHandle.EdgeAlpha = self.edgeAlpha;
            self.figureHandle.EdgeColor = self.edgeColor;
            
            % Store for reference
            self.r = r_zw_a;
            self.C = C_ba;
        end
        
        function updatePoints(self)
            
            
            if ~isempty(self.A) && ~isempty(self.b)
                V = lcon2vert(unique(A,'rows'),b);
            elseif ~isempty(self.vertices)
                V = self.vertices();
            else
                V = [[1;1;1],[-1;1;1],[1;-1;1],[-1;-1;1],[1;1;-1],[-1;1;-1],[1;-1;-1],[-1;-1;-1]].';
            end
            
            k = convhull(V);
            X = reshape(V(k,1),size(k,1),[]).';
            Y = reshape(V(k,2),size(k,1),[]).';
            Z = reshape(V(k,3),size(k,1),[]).';
            self.polyPoints = [X(:),Y(:),Z(:)].';
                
        end
    end
    methods (Access = private)
        % Principle DCMS are used to assemble quadcopter.
        function C = C1_DCM(~, theta)
            
            C = [1         0          0;
                0  cos(theta)  sin(theta);
                0 -sin(theta)  cos(theta)];
        end
        
        function C = C2_DCM(~, theta)
            
            C = [cos(theta) 0 -sin(theta);
                0          1           0;
                sin(theta) 0  cos(theta)];
        end
        
        function C =  C3_DCM(~, theta)
            C = [ cos(theta) sin(theta) 0;
                -sin(theta) cos(theta) 0;
                0        0    1];
        end
    end
end


