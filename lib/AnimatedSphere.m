classdef AnimatedSphere < handle
    properties
        % Position and attitude
        r
        C
        
        % Visual properties
        radius
        meshResolution
        faceColor
        edgeColor
        faceAlpha
        edgeAlpha
        
        % Working variables
        figureHandle
        spherePoints
    end
    
    methods
        function self = AnimatedSphere()
            self.radius = 1;
            self.meshResolution = 10;
            self.faceColor = 'flat';
            self.edgeColor = [0 0 0];
            self.faceAlpha = 1;
            self.edgeAlpha = 1;
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % Create cylinder with radius and mesh resolution. 
            % NOTE - radius can actually be a n x 1 column matrix of points
            % which define a varying radius profile.
            [X, Y, Z] = ellipsoid(0,0,0,self.radius,self.radius,self.radius,self.meshResolution);  
            
            % Store as wide matrix
            self.spherePoints = [X(:).';Y(:).';Z(:).'];
            
            % Create figure
            self.figureHandle = surf(X,Y,Z);
            
            % Rotate and translate using update()
            self.update(r_zw_a, C_ba);

        end
        
        function update(self, r_zw_a, C_ba)
            % Update geometry
            self.updatePoints()
            
            % Rotate and translate
            spherePointsRot = C_ba.'*self.spherePoints + r_zw_a;
            
            % Reshape intro matrix compatible with surf(X,Y,Z) function
            xSph = reshape(spherePointsRot(1,:),[],self.meshResolution + 1);
            ySph = reshape(spherePointsRot(2,:),[],self.meshResolution + 1);
            zSph = reshape(spherePointsRot(3,:),[],self.meshResolution + 1);
            
            % Update data
            self.figureHandle.XData = xSph;
            self.figureHandle.YData = ySph;
            self.figureHandle.ZData = zSph;
            
            % Update visual properties
            self.figureHandle.FaceColor = self.faceColor;
            self.figureHandle.FaceAlpha = self.faceAlpha;
            self.figureHandle.EdgeAlpha = self.edgeAlpha;
            self.figureHandle.EdgeColor = self.edgeColor;
            
            % Save to object
            self.r = r_zw_a;
            self.C = C_ba;
        end
        
        function updatePoints(self)
            % NOTE - radius can actually be a n x 1 column matrix of points
            % which define a varying radius profile.
            
            % TODO: unneccessary calling of ellipsoid() every time?
            % This might actually significantly effect speed.
            [X, Y, Z] = ellipsoid(0,0,0,self.radius,self.radius,self.radius,self.meshResolution);   

            % Store as wide matrix
            self.spherePoints = [X(:).';Y(:).';Z(:).'];
        end
     end
end
