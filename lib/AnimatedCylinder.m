classdef AnimatedCylinder < handle
    properties
        % Position and attitude
        r
        C
        
        % Visual properties
        radius
        height
        meshResolution
        
        % Working variables
        figureHandle
        cylPoints
    end
    
    methods
        function self = AnimatedCylinder()
            self.radius = 1;
            self.height = 3;    
            self.meshResolution = 10;
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % Create cylinder with radius and mesh resolution. 
            % NOTE - radius can actually be a n x 1 column matrix of points
            % which define a varying radius profile.
            [Xcyl, Ycyl, Zcyl] = cylinder(self.radius, self.meshResolution);
            
            % Stretch to correct height and center at centroid.
            Zcyl = Zcyl.*self.height - self.height/2;
            
            % Store as wide matrix
            self.cylPoints = [Xcyl(:).';Ycyl(:).';Zcyl(:).'];
            
            % Create figure
            self.figureHandle = surf(Xcyl,Ycyl,Zcyl);
            
            % Rotate and translate using update()
            self.update(r_zw_a, C_ba);

        end
        
        function update(self, r_zw_a, C_ba)
            % Rotate and translate
            cylPointsRot = C_ba.'*self.cylPoints + r_zw_a;
            
            % Reshape intro matrix compatible with surf(X,Y,Z) function
            xCyl = reshape(cylPointsRot(1,:),[],self.meshResolution + 1);
            yCyl = reshape(cylPointsRot(2,:),[],self.meshResolution + 1);
            zCyl = reshape(cylPointsRot(3,:),[],self.meshResolution + 1);
            
            % Update data
            self.figureHandle.XData = xCyl;
            self.figureHandle.YData = yCyl;
            self.figureHandle.ZData = zCyl;
            
        end
    end
end
