classdef AnimatedBoxyCar < handle
    % Quadcopter visual model - an element of elements.
    properties
        % Position and attitude relative to inertial frame
        r_zw_a
        C_ba
        
        % Visual properties
        scale        
        
        % Car parts
        body
        wheel_fl
        wheel_fr
        wheel_rl
        wheel_rr
        axle_fl
        axle_fr
        axle_rl
        axle_rr
        
        l_f     % Distance between front axle and center of gravity
        l_r     % Distance between rear axle and center of gravity
        l_w     % Car width
        l_h     % Car height
        wheel_radius     % Wheel radius
        wheel_thickness  % Wheel thickness
        wheel_offset_h    % Offset between car body and wheels
        wheel_offset_v    % Offset between car body and wheels
        
        axle_width
        delta
        
        % Colors
        color_body
        color_wheel
        color_axle
    end
    
    methods
        function self = AnimatedBoxyCar(delta)
            self.scale = 2;    
            self.l_f = 1.5;
            self.l_r = 1.5;
            self.l_w = 1.5;
            self.l_h = 0.1;
            self.wheel_radius = 0.3;   
            self.wheel_thickness = 0.15;
            self.wheel_offset_h = 0.3;
            self.wheel_offset_v = self.wheel_radius*0.8;
            self.axle_width = 0.075;
            self.delta = delta;
            
            self.color_body = [0 0.4470 0.7410];
            self.color_wheel = 'k'; 
            self.color_axle = [104,104,104]/255;
        end
        
        function plot(self, r_zw_a, C_ba)
            % @var@input delta : steering angle in radians
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            delta = self.delta;
            
            hold on
            self.body = AnimatedBox();
            self.body.length = self.l_f + self.l_r;
            self.body.width  = self.l_w;
            self.body.height = self.l_h;
            self.body.faceColor = self.color_body;
            self.body.plot(r_zw_a, C_ba);
            
            % Add wheels
            % Front left
            self.wheel_fl = AnimatedCylinder();
            self.wheel_fl.radius = self.wheel_radius;
            self.wheel_fl.height = self.wheel_thickness;
            self.wheel_fl.faceColor = self.color_wheel;
            r_pz_b = [self.l_f - self.wheel_offset_h/2; self.l_w/2 + self.wheel_offset_v;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([pi/2;0;delta]);
            self.wheel_fl.plot(r_pz_a + r_zw_a, C_pb*C_ba);
            % Front right
            self.wheel_fr = AnimatedCylinder();
            self.wheel_fr.radius = self.wheel_radius;
            self.wheel_fr.height = self.wheel_thickness;
            self.wheel_fr.faceColor = self.color_wheel;
            r_pz_b = [self.l_f - self.wheel_offset_h/2; -self.l_w/2 - self.wheel_offset_v;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([-pi/2;0;delta]);
            self.wheel_fr.plot(r_pz_a + r_zw_a, C_pb*C_ba);
            % Rear left
            self.wheel_rl = AnimatedCylinder();
            self.wheel_rl.radius = self.wheel_radius;
            self.wheel_rl.height = self.wheel_thickness;
            self.wheel_rl.faceColor = self.color_wheel;
            r_pz_b = [-self.l_r + self.wheel_offset_h; self.l_w/2 + self.wheel_offset_v;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([pi/2;0;0]);
            self.wheel_rl.plot(r_pz_a + r_zw_a, C_pb*C_ba);
            % Rear right
            self.wheel_rr = AnimatedCylinder();
            self.wheel_rr.radius = self.wheel_radius;
            self.wheel_rr.height = self.wheel_thickness;
            self.wheel_rr.faceColor = self.color_wheel;
            r_pz_b = [-self.l_r + self.wheel_offset_h; -self.l_w/2 - self.wheel_offset_v;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([-pi/2;0;0]);
            self.wheel_rr.plot(r_pz_a + r_zw_a, C_pb*C_ba);
            
            
            % Add axles
            % Front left
            self.axle_fl = AnimatedCylinder();
            self.axle_fl.radius = self.axle_width;
            self.axle_fl.height = self.wheel_offset_v;
            self.axle_fl.faceColor = self.color_axle;
            r_pz_b = [self.l_f - self.wheel_offset_h/2; self.l_w/2 + self.wheel_offset_v/2;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([pi/2;0;0]);
            self.axle_fl.plot(r_pz_a + r_zw_a, C_pb*C_ba);
            % Front right    
            self.axle_fr = AnimatedCylinder();
            self.axle_fr.radius = self.axle_width;
            self.axle_fr.height = self.wheel_offset_v;
            self.axle_fr.faceColor = self.color_axle;
            r_pz_b = [self.l_f - self.wheel_offset_h/2; -self.l_w/2 - self.wheel_offset_v/2;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([-pi/2;0;0]);
            self.axle_fr.plot(r_pz_a + r_zw_a, C_pb*C_ba);
            % Rear left
            self.axle_rl = AnimatedCylinder();
            self.axle_rl.radius = self.axle_width;
            self.axle_rl.height = self.wheel_offset_v;
            self.axle_rl.faceColor = self.color_axle;
            r_pz_b = [-self.l_r + self.wheel_offset_h; self.l_w/2 + self.wheel_offset_v/2;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([pi/2;0;0]);
            self.axle_rl.plot(r_pz_a + r_zw_a, C_pb*C_ba);
            % Rear right    
            self.axle_rr = AnimatedCylinder();
            self.axle_rr.radius = self.axle_width;
            self.axle_rr.height = self.wheel_offset_v;
            self.axle_rr.faceColor = self.color_axle;
            r_pz_b = [-self.l_r + self.wheel_offset_h; -self.l_w/2 - self.wheel_offset_v/2;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([-pi/2;0;0]);
            self.axle_rr.plot(r_pz_a + r_zw_a, C_pb*C_ba);
            hold off
            
            % All figure are now created - update all the data.
            self.update(r_zw_a, C_ba)
        end
        
        function update(self, r_zw_a, C_ba)
            delta = self.delta;
            % Body
            self.body.update(r_zw_a, C_ba)
            
            % wheel            
            r_pz_b = [self.l_f - self.wheel_offset_h/2; self.l_w/2 + self.wheel_offset_v;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([pi/2;0;delta]);
            self.wheel_fl.update(r_pz_a + r_zw_a, C_pb*C_ba);
            % Front right            
            r_pz_b = [self.l_f - self.wheel_offset_h/2; -self.l_w/2 - self.wheel_offset_v;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([-pi/2;0;delta]);
            self.wheel_fr.update(r_pz_a + r_zw_a, C_pb*C_ba);
            % Rear left            
            r_pz_b = [-self.l_r + self.wheel_offset_h; self.l_w/2 + self.wheel_offset_v;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([pi/2;0;0]);
            self.wheel_rl.update(r_pz_a + r_zw_a, C_pb*C_ba);
            % Rear right
            r_pz_b = [-self.l_r + self.wheel_offset_h; -self.l_w/2 - self.wheel_offset_v;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([-pi/2;0;0]);
            self.wheel_rr.update(r_pz_a + r_zw_a, C_pb*C_ba);
            
            
            % axle
            % Front left            
            r_pz_b = [self.l_f - self.wheel_offset_h/2; self.l_w/2 + self.wheel_offset_v/2;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([pi/2;0;0]);
            self.axle_fl.update(r_pz_a + r_zw_a, C_pb*C_ba);
            % Front right 
            r_pz_b = [self.l_f - self.wheel_offset_h/2; -self.l_w/2 - self.wheel_offset_v/2;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([-pi/2;0;0]);
            self.axle_fr.update(r_pz_a + r_zw_a, C_pb*C_ba);
            % Rear left
            r_pz_b = [-self.l_r + self.wheel_offset_h; self.l_w/2 + self.wheel_offset_v/2;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([pi/2;0;0]);
            self.axle_rl.update(r_pz_a + r_zw_a, C_pb*C_ba);
            % Rear right
            r_pz_b = [-self.l_r + self.wheel_offset_h; -self.l_w/2 - self.wheel_offset_v/2;0];
            r_pz_a = C_ba'*r_pz_b;
            C_pb = getDCMrotVec([-pi/2;0;0]);
            self.axle_rr.update(r_pz_a + r_zw_a, C_pb*C_ba);
            
            % Save to object
            self.r_zw_a = r_zw_a;
            self.C_ba = C_ba;
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
             


