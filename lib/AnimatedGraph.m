classdef AnimatedGraph < handle
% AnimatedBox Creates a simple 1x1x1 box/cube.
% The dimensions face color, edge color, and dimensions can all be modified be
% accessing the corresponding properties.

    properties
        r
        C
        
        graphPoints % [3 x N float] coordinates of the nodes of the graph
        adjacency % [N x N float] graph adjacency matrix
        edgeColor % [1 x 3 float] RGB triplet specifying face color. 
        edgeAlpha % [float] Transparency of edges on scale of 0 (transparent) to 1. 
        
        figureHandle
        graphHandle
    end
    
    methods 
        function self = AnimatedGraph()
            % Constructor - default properties
            self.graphPoints = [[1;0;0],[0;1;0],[0;0;1],[0;0;0]];
            self.adjacency = ones(4) - eye(4);
            self.edgeColor = [0 0 0];
            self.edgeAlpha = 1;
        end
        
        function plot(self,r_zw_a,C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % Generate nominal points corresponding to dimensions;
            self.updatePoints()
            
            % Reshape intro matrices compatible for surf(X,Y,Z) function
            self.graphHandle = graph(self.adjacency);
            
            r_pw_a = C_ba.'*self.graphPoints + r_zw_a;
            
            % Create plot
            %hold on
            self.figureHandle = plot(self.graphHandle,'NodeLabel',[],'Layout','subspace3');
            %hold off
            self.figureHandle.XData = r_pw_a(1,:);
            self.figureHandle.YData = r_pw_a(2,:);
            self.figureHandle.ZData = r_pw_a(3,:);
            
            % Rotate and translate using update()
            self.update(r_zw_a, C_ba)
        end
 
        
        function update(self, r_zw_a, C_ba)
            % Update geometry
            self.updatePoints()
            
            % Rotate and translate
            r_pw_a = C_ba.'*self.graphPoints + r_zw_a;
            
            % Update data
            self.figureHandle.XData = r_pw_a(1,:);
            self.figureHandle.YData = r_pw_a(2,:);
            self.figureHandle.ZData = r_pw_a(3,:);
            
            % Store for reference
            self.r = r_zw_a;
            self.C = C_ba;
        end

        function updatePoints(self)

        end
     end
end

