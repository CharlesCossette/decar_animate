classdef AnimatedTrace < handle
    % Animated Trace class is a special class that will create a trajectory
    % that "follows" a specific target element. This animation therefore
    % traces out dynamically the target's trajectory as it travels along
    % it.
    properties
        R
 
        target % [Animated*] Object to track        
        lineWidth % [float] width of trace line.
        color % [1 x 3 float] RGB triplet of line color.

        figureHandle
        firstUpdateFlag
    end
    
    methods
        function self = AnimatedTrace(targetElement)
            %TODO if element does not exist, create it?
            self.R = [];
            self.target = targetElement;  
            self.firstUpdateFlag = true;
            self.lineWidth = 2;
            self.color = 'red';
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % For this class, we are fed r and C matrices anyways, but they
            % do nothing since we are getting r,C info frmo targetElement
            
            % Create trace figure object
            hold on
            self.figureHandle = plot3([0;0],[0;0],[0;0],'LineWidth',self.lineWidth,'Color',self.color);
            hold off

        end
        
        function update(self, r_zw_a, C_ba)
            
            self.R = [self.R, self.target.r];
         
            % Update data
            self.figureHandle.XData = self.R(1,:);
            self.figureHandle.YData = self.R(2,:);
            self.figureHandle.ZData = self.R(3,:);
            
        end
    end
end
