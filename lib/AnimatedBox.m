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
        boxPoints
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
          
            self.updatePoints()
            X = reshape(self.boxPoints(1,:),4,5);
            Y = reshape(self.boxPoints(2,:),4,5);
            Z = reshape(self.boxPoints(3,:),4,5);
            
            figHandle = surf(X, Y, Z);
            self.figureHandle = figHandle;
            self.update(r_zw_a, C_ba)
        end
 
        
        function update(self, r_zw_a, C_ba)
            self.updatePoints();

            boxRot = C_ba.'*self.boxPoints + r_zw_a;
            
            xRot = reshape(boxRot(1,:),4,5);
            yRot = reshape(boxRot(2,:),4,5);
            zRot = reshape(boxRot(3,:),4,5);
            
            self.figureHandle.XData = xRot;
            self.figureHandle.YData = yRot;
            self.figureHandle.ZData = zRot;
            
        end
        
    end
     methods (Access = private)
        function updatePoints(self)

            % Get box points for the specific points
            xRect = [0 0 0 0 0; -1 -1 1 1 -1; -1 -1 1 1 -1; 0 0 0 0 0]*self.length/2;
            yRect = [0 0 0 0 0; -1 1  1 -1 -1;  -1 1 1 -1 -1; 0 0 0 0 0]*self.width/2;
            zRect = [-1 -1 -1 -1 -1;-1 -1 -1 -1 -1; 1 1 1 1 1; 1 1 1 1 1]*self.height/2;
            self.boxPoints   = [xRect(:).' ; yRect(:).' ; zRect(:).'];
%             
        end
     end
end

