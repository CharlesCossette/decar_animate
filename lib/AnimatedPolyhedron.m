classdef AnimatedPolyhedron < handle
    %ANIMATEDPOLYHEDRON  Creates a CONVEX polyhedron by specifiying either the
    %vertices or the A,b matrices corresponding to inequality set A*r <= b.
    properties
        % Position and attitude
        r
        C
        
        % Visual properties
        vertices
        A
        b
        faceColor
        edgeColor
        faceAlpha
        edgeAlpha
        
        % Working variables
        figureHandle
        polyPoints
        
    end
    properties (Access = private)
        A_poly
        b_poly
    end
    
    methods
        function self = AnimatedPolyhedron()
            % Constructor - default properties
            self.faceColor = [0.5 0.5 0.5];
            self.edgeColor = [0 0 0];
            self.faceAlpha = 0.5;
            self.edgeAlpha = 1;
        end
        
        function plot(self,r_zw_a,C_ba)
            % BUILD - this function gets called during the animation build.
            % it is what actually creates the graphic object in the first
            % place.
            
            % Generate nominal points corresponding to dimensions;
            self.updatePoints()
                        
            % Rotate and translate using update()
            self.update(r_zw_a, C_ba)
        end
        
        
        function update(self, r_zw_a, C_ba)

            % Rotate and translate
            polyRot = C_ba.'*self.polyPoints + r_zw_a;
            
            % Update data 
            self.figureHandle.Vertices = polyRot.';
            self.figureHandle.FaceColor = self.faceColor;
            self.figureHandle.FaceAlpha = self.faceAlpha;
            self.figureHandle.EdgeAlpha = self.edgeAlpha;
            self.figureHandle.EdgeColor = self.edgeColor;
            
            % Store for reference
            self.r = r_zw_a;
            self.C = C_ba;
        end
        
        function updatePoints(self)
            
            if ~isempty(self.A) && ~isempty(self.b)
                self.A_poly = self.A;
                self.b_poly = self.b;
            elseif ~isempty(self.vertices)
                V = self.vertices;
                [self.A_poly,self.b_poly] = vert2lcon(V);
            else
                V = [[1;1;1],[-1;1;1],[1;-1;1],[-1;-1;1],[1;1;-1],[-1;1;-1],[1;-1;-1],[-1;-1;-1]].';
                [self.A_poly,self.b_poly] = vert2lcon(V);
            end
            
            self.figureHandle = plotregion(self.A_poly, self.b_poly);
            
            self.polyPoints = self.figureHandle.Vertices.';
            
        end
        
        
       
    end
    
end
