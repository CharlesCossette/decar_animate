classdef AnimatedCylinder < handle
    properties
        r
        C
        
        radius
        height
        meshResolution
        
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
            [Xcyl, Ycyl, Zcyl] = cylinder(self.radius, self.meshResolution);
            
            Zcyl = Zcyl.*self.height - self.height/2;
            self.cylPoints = [Xcyl(:).';Ycyl(:).';Zcyl(:).'];

            self.figureHandle = surf(Xcyl,Ycyl,Zcyl);
            
            self.update(r_zw_a, C_ba);

        end
        
        function update(self, r_zw_a, C_ba)
            
            cylPointsRot = C_ba.'*self.cylPoints + r_zw_a;
            
            % Plot
            xCyl = reshape(cylPointsRot(1,:),[],self.meshResolution + 1);
            yCyl = reshape(cylPointsRot(2,:),[],self.meshResolution + 1);
            zCyl = reshape(cylPointsRot(3,:),[],self.meshResolution + 1);
            
            self.figureHandle.XData = xCyl;
            self.figureHandle.YData = yCyl;
            self.figureHandle.ZData = zCyl;
            
        end
    end
end
