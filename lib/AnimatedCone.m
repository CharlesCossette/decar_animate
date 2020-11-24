classdef AnimatedCone < handle
%ANIMATEDCONE Creates a cone element, or a "chopped" cone element by
% specifying the two radii at each end of the cone, and the length of
% the cone. 

    properties
        r
        C
        
        baseRadius % [float] radius of circle at one end of the cone.
        tipRadius % [float] radius of circle at the other end of the cone.
        length % [float] length of the cone
        faceColor % [float] Transparency of box on scale of 0 (transparent) to 1. 
        faceAlpha % [float] Transparency of edges on scale of 0 (transparent) to 1. 
        edgeAlpha % [1 x 3 float] RGB triplet specifying face color. 
        edgeColor % [1 x 3 float] RGB triplet specifying edge color. 
        meshResolution % [int] Amount of segments in the circle.
        
        conePoints        
        figureHandle
    end
    
    methods
        function self = AnimatedCone()
            self.baseRadius = 0.5;
            self.tipRadius = 0;
            self.length = 1;
            self.meshResolution = 10;
            self.faceColor = 'r';
            self.edgeColor = [0.8, 0.8, 0.8];
            self.faceAlpha = 0.1;
            self.edgeAlpha = 1;
        end
        
        function plot(self,r_zw_a,C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % Create the mesh of the cone 
            self.updatePoints()
            
            % Rotate and translate
            conePointsRot = C_ba.'*self.conePoints + r_zw_a;
                        
            % Plot
            xCone = reshape(conePointsRot(1,:),self.meshResolution,[]);
            yCone = reshape(conePointsRot(2,:),self.meshResolution,[]);
            zCone = reshape(conePointsRot(3,:),self.meshResolution,[]);
            self.figureHandle = surf(xCone,yCone,zCone);
            
            % Some constant visual properties
            self.figureHandle.LineStyle = '-';
            self.figureHandle.FaceLighting = 'gouraud';
            self.figureHandle.SpecularColorReflectance = 0.5;
            
            self.update(r_zw_a, C_ba);            
        end
        
        function update(self,r_zw_a, C_ba)
            % Update geometry
            self.updatePoints()
            
            % Rotate and translate
            conePointsRot = C_ba.'*self.conePoints + r_zw_a;
            
            % Reshape data into matrices
            XCone = reshape(conePointsRot(1,:),self.meshResolution,[]);
            YCone = reshape(conePointsRot(2,:),self.meshResolution,[]);
            ZCone = reshape(conePointsRot(3,:),self.meshResolution,[]);
            
            % Update data
            self.figureHandle.XData = XCone;
            self.figureHandle.YData = YCone;
            self.figureHandle.ZData = ZCone;
            
            % Update Visual properties - these need to be here so you can
            % change them on-the-fly.
            self.figureHandle.FaceColor = self.faceColor;
            self.figureHandle.FaceAlpha = self.faceAlpha;
            self.figureHandle.EdgeAlpha = self.edgeAlpha;
            self.figureHandle.EdgeColor = self.edgeColor;
            
            % Save to object
            self.r = r_zw_a;
            self.C = C_ba;
        end

        function updatePoints(self)
            % Creates the actual meshgrid using built-in cylinder()
            % function.
            radii = self.tipRadius + (self.baseRadius - self.tipRadius)*linspace(0,1,self.meshResolution);
            [Xcone,Ycone,Zcone] = cylinder(radii);
            Zcone = Zcone*self.length;
            self.conePoints = [Xcone(:).' ; Ycone(:).' ; Zcone(:).'];
        end
     end
end

