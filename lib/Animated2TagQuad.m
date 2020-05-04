classdef Animated2TagQuad < AnimatedQuadcopter
    % ---------------------------------------------------------------------
    % Quadcopter visual model - an element of elements.
    % Supports varying tag positions in the x-y plane. 
    % TODO: 1) Consider the z-axis entry.
    %       2) Fix the bug that occurs when adding 2TagQuads of the same 
    %          r_iasti_b using addElement(quad, n).
    % ---------------------------------------------------------------------
    properties
        tagArm1
        tagArm2
        tag1
        tag2
        
        r_iasti_b % location of the secondary tag w.r.t. the base tag
                  % NOTE: ONLY THE FIRST TWO ENTRIES ARE CONSIDERED
    end
    
    methods
        function self = Animated2TagQuad(r_iasti_b)
            % TODO include all the functions from the superclass
            self = self@AnimatedQuadcopter;
            
            % Add arm holding the tag1
            self.tagArm1        = AnimatedCylinder();
            self.tagArm1.edgeColor = 'm';
            self.tagArm1.faceColor = 'm';
            
            % Add arm holding the tag2
            self.tagArm2        = AnimatedCylinder();
            self.tagArm2.edgeColor = 'm';
            self.tagArm2.faceColor = 'm';
            
            % Add tag1
            self.tag1        = AnimatedBox();
            self.tag1.edgeColor = 'm';
            self.tag1.faceColor = 'm';
            
            % Add tag2
            self.tag2        = AnimatedBox();
            self.tag2.edgeColor = 'm';
            self.tag2.faceColor = 'm';
            
            self.r_iasti_b = r_iasti_b;
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.             
            hold on
            
            self.tagArm1.plot(r_zw_a, C_ba);
            self.tagArm2.plot(r_zw_a, C_ba);
            self.tag1.plot(r_zw_a, C_ba);
            self.tag2.plot(r_zw_a, C_ba);
            
            % call the plot method from the super class
            plot@AnimatedQuadcopter(self, r_zw_a, C_ba)
            
            hold off
            
            % TODO: update only if a twoTagQuad figure handle exists
            % Update only if a pose has been specified.
            % We do not recall the update method to prevent recalling the
            % update method from the super class as well.
            if ~isempty(self.r) && ~isempty(self.C)
                % Tag 1
                self.tag1.updatePoints()
                r_t1z_b  = [ self.r_iasti_b(1)/2*self.scale;  self.r_iasti_b(2)/2*self.scale; (self.tag1.height+self.hub.height)/2+self.tagArm1.height];
                r_t1z_a  = self.C.'*r_t1z_b + self.r;
                self.tag1.update(r_t1z_a, self.C)

                % Tag 2
                self.tag2.updatePoints()
                r_t2z_b  = [ -self.r_iasti_b(1)/2*self.scale; -self.r_iasti_b(2)/2*self.scale; (self.tag2.height+self.hub.height)/2+self.tagArm2.height];
                r_t2z_a  = self.C.'*r_t2z_b + self.r;
                self.tag2.update(r_t2z_a, self.C)

                % Arm Tag 1
                self.tagArm1.updatePoints()
                r_a1z_b  = [ self.r_iasti_b(1)/2*self.scale;  self.r_iasti_b(2)/2*self.scale; (self.tagArm1.height+self.hub.height)/2];
                r_a1z_a  = self.C.'*r_a1z_b + self.r;
                self.tagArm1.update(r_a1z_a, self.C)

                % Arm Tag 2
                self.tagArm2.updatePoints()
                r_a2z_b  = [ -self.r_iasti_b(1)/2*self.scale;  -self.r_iasti_b(2)/2*self.scale; (self.tagArm2.height+self.hub.height)/2];
                r_a2z_a  = self.C.'*r_a2z_b + self.r;
                self.tagArm2.update(r_a2z_a, self.C)
            end
        end
        
        function update(self, r_zw_a, C_ba)            
            self.setDimensionsTags()
            
            % Tag 1
            r_t1z_b  = [ self.r_iasti_b(1)/2*self.scale;  self.r_iasti_b(2)/2*self.scale; (self.tag1.height+self.hub.height)/2+self.tagArm1.height];
            r_t1z_a  = C_ba.'*r_t1z_b + r_zw_a;
            self.tag1.update(r_t1z_a, C_ba)
            
            % Tag 2
            r_t2z_b  = [ -self.r_iasti_b(1)/2*self.scale;  -self.r_iasti_b(2)/2*self.scale; (self.tag2.height+self.hub.height)/2+self.tagArm2.height];
            r_t2z_a  = C_ba.'*r_t2z_b + r_zw_a;
            self.tag2.update(r_t2z_a, C_ba)
            
            % Arm Tag 1
            r_a1z_b  = [ self.r_iasti_b(1)/2*self.scale;  self.r_iasti_b(2)/2*self.scale; (self.tagArm1.height+self.hub.height)/2];
            r_a1z_a  = C_ba.'*r_a1z_b + r_zw_a;
            self.tagArm1.update(r_a1z_a, C_ba)
            
            % Arm Tag 2
            r_a2z_b  = [ -self.r_iasti_b(1)/2*self.scale;  -self.r_iasti_b(2)/2*self.scale; (self.tagArm2.height+self.hub.height)/2];
            r_a2z_a  = C_ba.'*r_a2z_b + r_zw_a;
            self.tagArm2.update(r_a2z_a, C_ba)
            
            % call the update method from the super class
            update@AnimatedQuadcopter(self, r_zw_a, C_ba)
        end
        
    end
    
    methods (Access = private)
        function setDimensionsTags(self)
            % If self.scale is changed, this function needs to be called
            % again to implement the change.
            
            % tag arm 1
            self.tagArm1.radius = 0.02*self.scale;
            self.tagArm1.height = 0.3*self.scale;
            
            % tag arm 2
            self.tagArm2.radius = 0.02*self.scale;
            self.tagArm2.height = 0.3*self.scale;
            
            % tag 1
            self.tag1.length = 0.075*self.scale;
            self.tag1.width  = 0.075*self.scale;
            self.tag1.height = 0.025*self.scale;
            
            % tag 2
            self.tag2.length = 0.075*self.scale;
            self.tag2.width  = 0.075*self.scale;
            self.tag2.height = 0.025*self.scale;
        end
        
    end
end