classdef AnimatedTrace < handle
    % Animated Trace class is a special class that will create a trajectory
    % that "follows" a specific target element. This animation therefore
    % traces out dynamically the target's trajectory as it travels along
    % it.
    properties
        % History of positions matrix [3 x N]
        R

        % Object to track
        target
        
        % TODO - add access to more properties
        LineWidth
        Color
        
        % Working variables
        figureHandle
        firstUpdateFlag

    end
    
    methods
        function self = AnimatedTrace(targetElement)
            %TODO if element does not exist, create it?
            self.R = [];
            self.target = targetElement;  
            self.firstUpdateFlag = true;
            self.LineWidth = 2;
            self.Color = 'red';
        end
        
        function plot(self, r_zw_a, C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % For this class, we are fed r and C matrices anyways, but they
            % do nothing since we are getting
            
            % Create trace figure object
            hold on
            self.figureHandle = plot3([0;0],[0;0],[0;0],'LineWidth',self.LineWidth,'Color',self.Color);
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
