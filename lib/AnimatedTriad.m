classdef AnimatedTriad < handle
%ANIMATEDTRIAD Creates a classic "coordinate axes" triad consisting of red,
% green, blue arrows, all orthogonal to each other.
    properties
        r
        C

        length % [float] length of the arrows.
        
        xHandle
        yHandle
        zHandle        
    end
    
    methods
        function self = AnimatedTriad()
            self.length = 1;
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % Create cylinder with radius and mesh resolution. 
            % NOTE - radius can actually be a n x 1 column matrix of points
            % which define a varying radius profile.
            %[xCyl, yCyl, zCyl] = cylinder(self.radius, self.meshResolution);
            is_hold = ishold;
            hold on
            self.xHandle = quiver3(0,0,0,self.length,0,0);
            self.xHandle.LineWidth = 2;
            self.xHandle.Color = 'red';
            self.yHandle = quiver3(0,0,0,0,self.length,0);
            self.yHandle.LineWidth = 2;
            self.yHandle.Color = 'green';
            self.zHandle = quiver3(0,0,0,0,0,self.length);
            self.zHandle.LineWidth =2 ;
            self.zHandle.Color = 'blue';
            if ~is_hold
                hold off
            end
            
            % Rotate and translate using update()
            self.update(r_zw_a, C_ba);

        end
        
        function update(self, r_zw_a, C_ba)
            
            UVW_X = C_ba.'*[1;0;0];
            UVW_Y = C_ba.'*[0;1;0];
            UVW_Z = C_ba.'*[0;0;1];
            
            self.xHandle.UData = UVW_X(1);
            self.yHandle.UData = UVW_Y(1);
            self.zHandle.UData = UVW_Z(1);
            self.xHandle.VData = UVW_X(2);
            self.yHandle.VData = UVW_Y(2);
            self.zHandle.VData = UVW_Z(2);
            self.xHandle.WData = UVW_X(3);
            self.yHandle.WData = UVW_Y(3);
            self.zHandle.WData = UVW_Z(3);
            
            self.xHandle.XData = r_zw_a(1);
            self.yHandle.XData = r_zw_a(1);
            self.zHandle.XData = r_zw_a(1);
            self.xHandle.YData = r_zw_a(2);
            self.yHandle.YData = r_zw_a(2);
            self.zHandle.YData = r_zw_a(2);
            self.xHandle.ZData = r_zw_a(3);
            self.yHandle.ZData = r_zw_a(3);
            self.zHandle.ZData = r_zw_a(3);
             
            % Save to object
            self.r = r_zw_a;
            self.C = C_ba;
        end
        
     end
end
