

classdef AnimatedCone < handle
    %ANIMATEDCONE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Position and attitude
        r
        C
        
        % Visual properties
        baseRadius
        length
        faceColor
        edgeColor
        meshResolution
        
        % Internal variables
        conePoints        
        figureHandle
    end
    
    methods
        function self = AnimatedCone()
            self.baseRadius = 0.5;
            self.length = 1;
            self.meshResolution = 10;
            self.faceColor = 'r';
        end
        
        function plot(self,r_zw_a,C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % Create the mesh of the cone         
            radii = linspace(0,self.baseRadius,self.meshResolution);      
            alph  = linspace(0,2*pi,self.meshResolution);       % Angle of revolution of cone
            [R,THETA] = meshgrid(radii,alph);
            Xcone = R.*cos(THETA);
            Ycone = R.*sin(THETA);
            Zcone = R./self.baseRadius*self.length;
            self.conePoints = [Xcone(:).' ; Ycone(:).' ; Zcone(:).'];
            
            
            % Rotate and translate
            conePointsRot = C_ba.'*self.conePoints + r_zw_a;
            
            % Plot
            xCone = reshape(conePointsRot(1,:),[],self.meshResolution);
            yCone = reshape(conePointsRot(2,:),[],self.meshResolution);
            zCone = reshape(conePointsRot(3,:),[],self.meshResolution);
            self.figureHandle = surf(xCone,yCone,zCone);
            axis equal
            axis vis3d
            
            % Make cone colour
            % TODO - parameterize visual properties
            self.figureHandle.FaceColor = self.faceColor;
            alpha(self.figureHandle,0.1)
            self.figureHandle.LineStyle = '-';
            self.figureHandle.EdgeAlpha = 1;
            self.figureHandle.EdgeColor = [.8 .8 .8];
            self.figureHandle.SpecularColorReflectance = 0.5;
            self.figureHandle.FaceLighting = 'gouraud';
            
        end
        
        function update(self,r_zw_a, C_ba)
             % Rotate and translate
            conePointsRot = C_ba.'*self.conePoints + r_zw_a;
            
            % Reshape data into matrices
            xCone = reshape(conePointsRot(1,:),[],self.meshResolution);
            yCone = reshape(conePointsRot(2,:),[],self.meshResolution);
            zCone = reshape(conePointsRot(3,:),[],self.meshResolution);
            
            % Update data
            self.figureHandle.XData = xCone;
            self.figureHandle.YData = yCone;
            self.figureHandle.ZData = zCone;
        end
    end
end

