classdef AnimatedSatellite < handle
    %ANIMATEDSATELLITE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Position and attitude
        r
        C
        
        % Visual properties
        scale
    end
    properties (SetAccess = private)
        hub
        arm
        panel
    end
    
    methods
        function self = AnimatedSatellite()
            self.scale = 2;      
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.

            % Add center "hub" or "base" of satellite.
            hold on
            self.hub = AnimatedBox();
            self.hub.length = 0.3*self.scale;
            self.hub.width = 0.3*self.scale;
            self.hub.height = 0.5*self.scale;
            self.hub.plot(r_zw_a, C_ba);
            
            % Add arms
            self.arm.left = AnimatedCylinder();
            self.arm.left.radius = 0*self.scale;
            self.arm.left.height = 0*self.scale;
            self.arm.left.plot(r_zw_a, C_ba);
            
            self.arm.right = AnimatedCylinder();
            self.arm.right.radius = 0*self.scale;
            self.arm.right.height = 0*self.scale;
            self.arm.right.plot(r_zw_a, C_ba);
            
            % Add panels
            self.panel.left = AnimatedBox();
            self.panel.left.length = 0*self.scale;
            self.panel.left.width = 0*self.scale;
            self.panel.left.height = 0*self.scale;
            self.panel.left.plot(r_zw_a, C_ba);
            
            self.panel.right = AnimatedBox();
            self.panel.right.length = 0*self.scale;
            self.panel.right.width = 0*self.scale;
            self.panel.right.height = 0*self.scale;
            self.panel.right.plot(r_zw_a, C_ba);
            
            hold off
            
            % All figure are now created - update all the data.
            self.update(r_zw_a, C_ba)
        end
        
        function update(self, r_zw_a, C_ba)
            
            % TODO - update the sub elements kinematics
            
            self.hub.update(r, C)
            self.arm.left.update(r, C)
            self.arm.right.update(r, C)
            self.panel.left.update(r, C)
            self.panel.right.update(r, C)
            
            % Save to object
            self.r = r_zw_a;
            self.C = C_ba;
            
        end
        
    end
    
    methods (Access = private)
        % Principle DCMS are used to assemble quadopter.
        function C = C1_DCM(~, theta)

            C = [1         0          0;
                 0  cos(theta)  sin(theta);
                 0 -sin(theta)  cos(theta)];
        end 
       
        function C = C2_DCM(~, theta)

            C = [cos(theta) 0 -sin(theta);
                 0          1           0;
                 sin(theta) 0  cos(theta)];
        end
        
        function C =  C3_DCM(~, theta)
            C = [ cos(theta) sin(theta) 0;
                 -sin(theta) cos(theta) 0;
                          0        0    1];
        end

    end
end

