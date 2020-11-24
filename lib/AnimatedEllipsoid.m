classdef AnimatedEllipsoid < handle
% AnimatedEllipsoid Creates a simple ellipsoid.
%
% *AnimatedEllipsoid Properties:*
%
%    xRadius - [float] radius in x direction
%    yRadius - [float] radius in y direction
%    zRadius - [float] radius in z direction
%    faceAlpha - [float] Transparency of box on scale of 0 (transparent) to
%    1. 
%    edgeAlpha - [float] Transparency of edges on scale of 0 (transparent)
%    to 1. 
%    faceColor - [1 x 3 float] RGB triplet specifying face color. 
%    edgeColor - [1 x 3 float] RGB triplet specifying edge color. 
%    meshResolution - [int] Amount of segments in the circle.
    properties
        % Position and attitude
        r
        C
        
        % Visual properties
        xRadius
        yRadius
        zRadius
        meshResolution
        faceColor
        edgeColor
        faceAlpha
        edgeAlpha
        
        % Working variables
        figureHandle
        ellipsoidPoints
    end
    
    methods
        function self = AnimatedEllipsoid()
            self.xRadius = 1;
            self.yRadius = 0.5;
            self.zRadius = 0.5;
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
            [X, Y, Z] = ellipsoid(0,0,0,self.xRadius,self.yRadius,self.zRadius,self.meshResolution);  
            
            % Store as wide matrix
            self.ellipsoidPoints = [X(:).';Y(:).';Z(:).'];
            
            % Create figure
            self.figureHandle = surf(X,Y,Z);
            
            % Rotate and translate using update()
            self.update(r_zw_a, C_ba);

        end
        
        function update(self, r_zw_a, C_ba)
            % Update geometry
            self.updatePoints()
            
            % Rotate and translate
            ellipsoidPointsRot = C_ba.'*self.ellipsoidPoints + r_zw_a;
            
            % Reshape intro matrix compatible with surf(X,Y,Z) function
            xEll = reshape(ellipsoidPointsRot(1,:),[],self.meshResolution + 1);
            yEll = reshape(ellipsoidPointsRot(2,:),[],self.meshResolution + 1);
            zEll = reshape(ellipsoidPointsRot(3,:),[],self.meshResolution + 1);
            
            % Update data
            self.figureHandle.XData = xEll;
            self.figureHandle.YData = yEll;
            self.figureHandle.ZData = zEll;
            
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
            [X, Y, Z] = ellipsoid(0,0,0,self.xRadius,self.yRadius,self.zRadius,self.meshResolution);  

            % Store as wide matrix
            self.ellipsoidPoints = [X(:).';Y(:).';Z(:).'];
        end
     end
end
