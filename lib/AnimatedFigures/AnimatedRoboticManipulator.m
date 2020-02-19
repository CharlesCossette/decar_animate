classdef AnimatedRoboticManipulator < handle
    %ANIMATEDROBOTICMANIPULATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Position and attitude
        r
        C
        
        % Visual properties
        scale
    end
    properties (SetAccess = private)
        arm1
        arm2
        arm3
        wrist
    end
    
    methods
        function self = AnimatedRoboticManipulator()
            self.scale = 2;      
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.

            % TODO - make the figure
            hold on
            
            % Draw arms
            self.arm1 = AnimatedBox();
            self.arm1.length = 0*self.scale;
            self.arm1.width = 0*self.scale;
            self.arm1.height = 0*self.scale;
            self.arm1.plot(r_zw_a, C_ba);
            
            self.arm2 = AnimatedBox();
            self.arm2.length = 0*self.scale;
            self.arm2.width = 0*self.scale;
            self.arm2.height = 0*self.scale;
            self.arm2.plot(r_zw_a, C_ba);
            
            self.arm3 = AnimatedBox();
            self.arm3.length = 0*self.scale;
            self.arm3.width = 0*self.scale;
            self.arm3.height = 0*self.scale;
            self.arm3.plot(r_zw_a, C_ba);
            
            self.wrist = AnimatedCone();
            self.wrist.baseRadius = 0*self.scale;
            self.wrist.length = 0*self.scale;
            self.wrist.plot(r_zw_a, C_ba);
            
            hold off
            
            % All figure are now created - update all the data.
            self.update(r_zw_a, C_ba)
        end
        
        function update(self, r_zw_a, C_ba)
            
            % TODO - update the sub elements kinematics
            
            self.arm1.update(r, C)
            self.arm2.update(r, C)
            self.arm3.update(r, C)
            self.wrist.update(r, C)
            
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

