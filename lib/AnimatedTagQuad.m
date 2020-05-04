classdef AnimatedTagQuad < AnimatedQuadcopter
    % Quadcopter visual model - an element of elements.
    properties
        tagArm
        tag
    end
    
    methods
        function self = AnimatedTagQuad()
            % TODO: include all the functions from the superclass
            self = self@AnimatedQuadcopter;
            
            % Add arm holding the tag
            self.tagArm     = AnimatedCylinder();
            self.tagArm.edgeColor = 'm';
            self.tagArm.faceColor = 'm';
            
            % Add tag
            self.tag        = AnimatedBox();
            self.tag.edgeColor = 'm';
            self.tag.faceColor = 'm';
            
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            hold on
            
            self.tagArm.plot(r_zw_a, C_ba);
            self.tag.plot(r_zw_a, C_ba);
            
            % call the plot method from the super class
            plot@AnimatedQuadcopter(self, r_zw_a, C_ba)
            
            hold off
            
            % TODO: update only if a oneTagQuad figure handle exists
            % Update only if a pose has been specified.
            % We do not recall the update method to prevent recalling the
            % update method from the super class as well.
            if ~isempty(self.r) && ~isempty(self.C)
                % Tag
                self.tag.updatePoints()
                r_tz_b  = [ 0;  0; (self.tag.height+self.hub.height)/2+self.tagArm.height];
                r_tz_a  = self.C.'*r_tz_b + self.r;
                self.tag.update(r_tz_a, self.C)

                % Arm Tag
                self.tagArm.updatePoints()
                r_az_b  = [ 0;  0; (self.tagArm.height+self.hub.height)/2];
                r_az_a  = self.C.'*r_az_b + self.r;
                self.tagArm.update(r_az_a, self.C)
            end
        end
        
        function update(self, r_zw_a, C_ba)            
            self.setDimensionsTags()
            
            % Tag
            r_tz_b  = [ 0;  0; (self.tag.height+self.hub.height)/2+self.tagArm.height];
            r_tz_a  = C_ba.'*r_tz_b + r_zw_a;
            self.tag.update(r_tz_a, C_ba)
            
            % Arm Tag
            r_az_b  = [ 0;  0; (self.tagArm.height+self.hub.height)/2];
            r_az_a  = C_ba.'*r_az_b + r_zw_a;
            self.tagArm.update(r_az_a, C_ba)
            
            % call the update method from the super class
            update@AnimatedQuadcopter(self, r_zw_a, C_ba)
        end
        
    end
    
    methods (Access = private)
        function setDimensionsTags(self)
            % If self.scale is changed, this function needs to be called
            % again to implement the change.
            
            % tag arm
            self.tagArm.radius = 0.02*self.scale;
            self.tagArm.height = 0.3*self.scale;
            
            % tag
            self.tag.length    = 0.075*self.scale;
            self.tag.width     = 0.075*self.scale;
            self.tag.height    = 0.025*self.scale;
        end
        
    end
end