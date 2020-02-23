classdef AnimatedBox < handle
    % TODO - link faceColor and edgeColor
    % TODO - be able to change face/edge color after the build
    properties
        % Position and attitude
        r
        C
        
        % Visual properties
        length
        width
        height
        faceColor
        edgeColor
        
        % Working variables
        boxPoints
        figureHandle
        
    end
    
    methods 
        function self = AnimatedBox()
            % Constructor
            self.length = 1;
            self.width = 1;
            self.height = 1;
            self.faceColor = 'flat';  
            self.edgeColor = [0;0;0];
            
        end
        
        function plot(self,r_zw_a,C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % Generate nominal points corresponding to dimensions;
            self.updatePoints()
            
            % Reshape intro matrices compatible for surf(X,Y,Z) function
            X = reshape(self.boxPoints(1,:),2,[]);
            Y = reshape(self.boxPoints(2,:),2,[]);
            Z = reshape(self.boxPoints(3,:),2,[]);
            
            % Create plot
            self.figureHandle = surf(X, Y, Z);
            self.figureHandle.FaceColor = self.faceColor;
            self.figureHandle.EdgeColor = self.edgeColor;
            
            % Rotate and translate using update()
            %self.update(r_zw_a, C_ba)
        end
 
        
        function update(self, r_zw_a, C_ba)
            % Update nominal box points if dimensions have changed.
            self.updatePoints();
            
            % Rotate and translate
            boxRot = C_ba.'*self.boxPoints + r_zw_a;
            
            % Reshape into matrices compatible for surf(X,Y,Z) function
            xRot = reshape(boxRot(1,:),2,[]);
            yRot = reshape(boxRot(2,:),2,[]);
            zRot = reshape(boxRot(3,:),2,[]);
            
            % Update data
            self.figureHandle.XData = xRot;
            self.figureHandle.YData = yRot;
            self.figureHandle.ZData = zRot;
            
            % Store for reference
            self.r = r_zw_a;
            self.C = C_ba;
        end
        
    end
     methods (Access = private)
        function updatePoints(self)
            % Nominal box points centered at 0,0,0 used to constuct surf
            xRect = [-1  1  1 1 -1 -1  1 -1 -1; -1  1 1  1 -1 -1  1  1 1]*self.length/2;
            yRect = [-1 -1  1 1  1  1  1  1  1; -1 -1 1 -1 -1 -1 -1  1 1]*self.width/2;
            zRect = [-1 -1 -1 1  1 -1 -1 -1  1;  1  1 1  1  1 -1 -1 -1 1]*self.height/2;
            self.boxPoints   = [xRect(:).' ; yRect(:).' ; zRect(:).'];
            
        end
     end
end

