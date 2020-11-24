classdef AnimatedHusky < handle
% Clearpath Husky Ground vehicle visual model.
    properties
        r
        C
       
        hub % [AnimatedBox]
        wheel1 % [AnimatedCylinder]
        wheel2 % [AnimatedCylinder]
        wheel3 % [AnimatedCylinder]
        wheel4 % [AnimatedCylinder]
        
        scale % [float] Set to 1 for dimensionally-accurate husky.
    end
    
    methods
        function self = AnimatedHusky()
            % Constructor
            % TODO - parameterize relative component sizing.
            self.scale = 1;

            % Add center "hub" or "base" of vehicle.
            self.hub = AnimatedBox();
            self.hub.faceColor = [1 1 0]*0.9;
            
            % Add wheels.
            self.wheel1 = AnimatedCylinder();
            self.wheel2 = AnimatedCylinder();
            self.wheel3 = AnimatedCylinder();
            self.wheel4 = AnimatedCylinder();
            
            self.wheel1.faceColor = [1, 1, 1]*0.3;
            self.wheel2.faceColor = [1, 1, 1]*0.3;
            self.wheel3.faceColor = [1, 1, 1]*0.3;
            self.wheel4.faceColor = [1, 1, 1]*0.3;
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % For an element of elements, sub-elements are added as
            % properties of this class.
            
            self.hub.plot(r_zw_a, C_ba);
            hold on
            self.wheel1.plot(r_zw_a, C_ba);
            self.wheel2.plot(r_zw_a, C_ba);
            self.wheel3.plot(r_zw_a, C_ba);
            self.wheel4.plot(r_zw_a, C_ba);
            hold off
            
            % All figures are now created - update all the data.
            self.update(r_zw_a, C_ba)
        end
        
        function update(self, r_zw_a, C_ba)
            % For an element of elements, the update(r,C) function
            % implicitly defines how all the sub-elements are related.
            
            % Update geometry
            self.setDimensions()
            
            % Hub
            self.hub.update(r_zw_a, C_ba)
            
            if length(self.wheel1.radius) > 1
                radius = self.wheel1.radius(2);
            else
                radius = self.wheel1.radius;
            end
            
            % Wheels
            r_w1z_b  = [ (0.5*self.hub.length - radius);  (0.5*self.hub.width + self.wheel1.height/2); -self.hub.height/2];
            r_w2z_b  = [ -(0.5*self.hub.length - radius);  (0.5*self.hub.width + self.wheel1.height/2); -self.hub.height/2];
            r_w3z_b  = [ (0.5*self.hub.length - radius);  -(0.5*self.hub.width + self.wheel1.height/2); -self.hub.height/2];
            r_w4z_b  = [ -(0.5*self.hub.length - radius);  -(0.5*self.hub.width + self.wheel1.height/2); -self.hub.height/2];

            
            r_p1w_a = C_ba.'*r_w1z_b + r_zw_a;
            r_p2w_a = C_ba.'*r_w2z_b + r_zw_a;
            r_p3w_a = C_ba.'*r_w3z_b + r_zw_a;
            r_p4w_a = C_ba.'*r_w4z_b + r_zw_a;
            
            self.wheel1.update(r_p1w_a, self.C1_DCM(deg2rad(90))*C_ba)
            self.wheel2.update(r_p2w_a, self.C1_DCM(deg2rad(90))*C_ba)
            self.wheel3.update(r_p3w_a, self.C1_DCM(deg2rad(90))*C_ba)
            self.wheel4.update(r_p4w_a, self.C1_DCM(deg2rad(90))*C_ba)
            
            % Save to object
            self.r = r_zw_a;
            self.C = C_ba;
        end
    end
   
    methods (Access = private)
        % Principle DCMS are used to assemble vehicle.
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
        
        function setDimensions(self)
            % If self.scale is changed, this function needs to be called
            % again to implement the change. Luckily we run this every time
            % self.update(r,C) is called.
            
            radiusProfile = ones(20,1)*0.33/2*self.scale;
            radiusProfile(1) = 0;
            radiusProfile(end) = 0;
            
            self.hub.length = 0.874*self.scale;
            self.hub.width = 0.42*self.scale;
            self.hub.height = 0.260*self.scale;
            
            self.wheel1.radius = radiusProfile;
            self.wheel1.height = 0.125*self.scale;
            
            self.wheel2.radius = radiusProfile;
            self.wheel2.height = 0.125*self.scale;
            
            self.wheel3.radius = radiusProfile;
            self.wheel3.height = 0.125*self.scale;
            
            self.wheel4.radius = radiusProfile;
            self.wheel4.height = 0.125*self.scale;
        end
        
    end
end



