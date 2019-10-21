classdef Animation < handle
    properties
        figureNumber
        elements
    end
    
    methods
        function self = Animation(figNum)
            if nargin == 0
                self.figureNumber = [];
            else
                self.figureNumber = figNum;
            end

        end
        
        function addElement(self, element, numberOfCopies)
            
            className = class(element);
            searching = true;
            ind = 1;
            while searching 
                if isfield(self.elements, strcat(className,num2str(ind)))
                    ind = ind + 1;
                else
                    self.elements.(strcat(className,num2str(ind))) = element;
                    searching = false;
                end
                
                if ind > 100
                    error('Failed to add element.')
                end
            end
                
            if exist('numberOfCopies','var')
                for lv1 = ind + 1:numberOfCopies
                    self.elements.(strcat(className,num2str(lv1))) = element;
                end
            end
        end
        
        function build(self)
            if isempty(self.figureNumber)
                figure
            else
                figure(self.figureNumber)
            end
            
            elementNames = fieldnames(self.elements);
            numElements = numel(elementNames);
            
            hold off
            elementObj = self.elements.(elementNames{1});
            elementObj.plot([0;0;0], eye(3))
            hold on    
            for lv1 = 2:numElements
                elementObj = self.elements.(elementNames{lv1});
                elementObj.plot([0;0;0], eye(3))

            end
            hold off
            
            
            axis vis3d
            
        end 
        
        function update(self,r,C)
            
            elementNames = fieldnames(self.elements);
            numElements = numel(elementNames);
            for lv1 = 1:numElements
                elementObj = self.elements.(elementNames{lv1});
                elementObj.plot(r(:,lv1), eye(3))

            end
            axis([-inf inf -inf inf -inf inf])
            grid on
        end    
    end
end

