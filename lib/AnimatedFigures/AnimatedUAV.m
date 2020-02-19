classdef AnimatedUAV < handle
    %ANIMATEDUAV Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       % Position and attitude
        r
        C
        
        % Visual properties
        scale
    end
    properties (SetAccess = private)
        % Sub elements
        body
        wing
        tail
    end
    
    methods
        function self = AnimatedUAV()
            self.scale = 2;      
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.

            % TODO - make the figure
            hold on
            
            % Draw body
            self.body.nose = AnimatedCone();
            self.body.cone.baseRadius = 0*self.scale;
            self.body.cone.length = 0*self.scale;
            self.body.cone.plot(r_zw_a, C_ba);
            
            self.body.fuselage = AnimatedCylinder();
            self.body.fuselage.radius = 0*self.scale;
            self.body.fuselage.height = 0*self.scale;
            self.body.fuselage.plot(r_zw_a, C_ba);
            
            % Draw wings
            self.wing.left = AnimatedBox();
            self.wing.left.length = 0*self.scale;
            self.wing.left.width = 0*self.scale;
            self.wing.left.height = 0*self.scale;
            self.wing.left.plot(r_zw_a, C_ba);
            
            self.wing.right = AnimatedBox();
            self.wing.right.length = 0*self.scale;
            self.wing.right.width = 0*self.scale;
            self.wing.right.height = 0*self.scale;
            self.wing.right.plot(r_zw_a, C_ba);
            
            % Draw tail
            self.tail.vstab = AnimatedBox();
            self.tail.vstab.length = 0*self.scale;
            self.tail.vstab.width = 0*self.scale;
            self.tail.vstab.height = 0*self.scale;
            self.tail.vstab.plot(r_zw_a, C_ba);
            
            self.tail.hstab = AnimatedBox();
            self.tail.hstab.length = 0*self.scale;
            self.tail.hstab.width = 0*self.scale;
            self.tail.hstab.height = 0*self.scale;
            self.tail.hstab.plot(r_zw_a, C_ba);
            
            hold off
            
            % All figure are now created - update all the data.
            self.update(r_zw_a, C_ba)
        end
        
        function update(self, r_zw_a, C_ba)
            
            % TODO - update the sub elements kinematics
            
            % Body
            self.body.nose.update(r, C)
            self.body.fuselage.update(r, C)
            
            % Wing
            self.wing.left.update(r, C)
            self.wing.right.update(r, C)
            
            % Tail
            self.tail.vstab.update(r, C)
            self.tail.hstab.update(r, C)
            
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
