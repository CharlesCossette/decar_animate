classdef AnimatedQuadcopter < handle
    properties
        r
        C
        
        scale
        
        hub 
        arm1
        arm2
        prop1
        prop2
        prop3
        prop4
    end
    
    methods
        function self = AnimatedQuadcopter()
            self.scale = 2;      
            
        end
        
        function plot(self, r_zw_a, C_ba)
            hold on
            
            self.hub = AnimatedBox();
            self.hub.length = 0.3*self.scale;
            self.hub.width = 0.3*self.scale;
            self.hub.height = 0.1*self.scale;
            self.hub.plot(r_zw_a, C_ba);
            
            self.arm1 = AnimatedCylinder();
            self.arm1.radius = 0.05*self.scale;
            self.arm1.height = sqrt(2)*self.scale;
            self.arm1.plot(r_zw_a, C_ba);
            
            self.arm2 = AnimatedCylinder();
            self.arm2.radius = 0.05*self.scale;
            self.arm2.height = sqrt(2)*self.scale;
            self.arm2.plot(r_zw_a, C_ba);
            
            self.prop1 = AnimatedCone();
            self.prop1.baseRadius = 0.25*self.scale;
            self.prop1.length = 0;
            self.prop1.plot(r_zw_a, C_ba);
            
            self.prop2 = AnimatedCone();
            self.prop2.baseRadius = 0.25*self.scale;
            self.prop2.length = 0;
            self.prop2.plot(r_zw_a, C_ba);
            
            self.prop3 = AnimatedCone();
            self.prop3.baseRadius = 0.25*self.scale;
            self.prop3.length = 0;
            self.prop3.plot(r_zw_a, C_ba);
            
            self.prop4 = AnimatedCone();
            self.prop4.baseRadius = 0.25*self.scale;
            self.prop4.length = 0;
            self.prop4.plot(r_zw_a, C_ba);
            hold off
            
            self.update(r_zw_a, C_ba)
        end
        
        function update(self, r_zw_a, C_ba)
            
            % Hub
            self.hub.update(r_zw_a, C_ba)
            
            % Arms
            C_arm1b = self.C2_DCM(deg2rad(45))*self.C1_DCM(deg2rad(90));
            self.arm1.update(r_zw_a, C_arm1b*C_ba)
            
            C_arm2b = self.C2_DCM(deg2rad(-45))*self.C1_DCM(deg2rad(90));
            self.arm2.update(r_zw_a, C_arm2b*C_ba)
            
            % Props
            r_p1z_b  = [ 0.5*self.scale;  0.5*self.scale; self.hub.height/2];
            r_p2z_b  = [ 0.5*self.scale; -0.5*self.scale; self.hub.height/2];
            r_p3z_b  = [-0.5*self.scale; -0.5*self.scale; self.hub.height/2];
            r_p4z_b  = [-0.5*self.scale;  0.5*self.scale; self.hub.height/2];
            
            r_p1w_a = C_ba.'*r_p1z_b + r_zw_a;
            r_p2w_a = C_ba.'*r_p2z_b + r_zw_a;
            r_p3w_a = C_ba.'*r_p3z_b + r_zw_a;
            r_p4w_a = C_ba.'*r_p4z_b + r_zw_a;
            
            self.prop1.update(r_p1w_a, C_ba)
            self.prop2.update(r_p2w_a, C_ba)
            self.prop3.update(r_p3w_a, C_ba)
            self.prop4.update(r_p4w_a, C_ba)
        end
        
        
    end
    
    methods (Access = private)
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
             


