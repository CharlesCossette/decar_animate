classdef AnimatedBox < handle
    properties
        r
        C
        length
        width
        height
        faceColor
        edgeColor
        
        vertices
        figureHandle
        
    end
    
    methods 
        function self = AnimatedBox()
            % Constructor
            self.length = 1;
            self.width = 1;
            self.height =1;
            self.faceColor = 'r';           
            
        end
        
        function plot(self,r_zw_a,C_ba)
            V_b = self.updateVertices();
            
            V_a = C_ba.'*V_b + r_zw_a;
            
            verticesX = reshape(V_a(1,:), [4 6]);
            verticesY = reshape(V_a(2,:), [4 6]);
            verticesZ = reshape(V_a(3,:), [4 6]);
            
            figHandle = patch(verticesX, verticesY, verticesZ, self.faceColor);
            self.figureHandle = figHandle;
            axis vis3d
            view(3)
        end
 
        
        function update(self, r_zw_a, C_ba)
            V_b = self.updateVertices();
           
            V_a = C_ba.'*V_b + r_zw_a;
            
            verticesX = reshape(V_a(1,:), [4 6]);
            verticesY = reshape(V_a(2,:), [4 6]);
            verticesZ = reshape(V_a(3,:), [4 6]);
            
            self.figureHandle.XData = verticesX;
            self.figureHandle.YData = verticesY;
            self.figureHandle.ZData = verticesZ;
            
        end
        
    end
    methods (Access = private)
        function  V = updateVertices(self)
                        
            verticesX = [[1;1;1;1],[1;1;-1;-1],[-1;-1;-1;-1],[-1;-1;1;1],[1;1;-1;-1],[1;1;-1;-1]]*self.length/2;
            verticesY = [[1;1;-1;-1],[1;1;1;1],[-1;-1;1;1],[-1;-1;-1;-1],[-1;1;1;-1],[-1;1;1;-1]]*self.width/2;
            verticesZ = [[1;-1;-1;1],[1;-1;-1;1],[1;-1;-1;1],[1;-1;-1;1],[1;1;1;1],[-1;-1;-1;-1]]*self.height/2;
            V = [verticesX(:).'; verticesY(:).'; verticesZ(:).'];
            self.vertices = V;
            
        end
    end
end

