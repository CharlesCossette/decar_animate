classdef Animation < handle
    properties
        figureNumber
        elements
        axesHandle
        figureHandle
        
    end
    
    methods
        function self = Animation(figNum)
            if exist('figNum','var')
                self.figureNumber = figNum;
            end

        end
        
        function addElement(self, element, numberOfCopies)
            % Add a graphic element to the list
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
                    self.elements.(strcat(className,num2str(lv1))) = eval(className);
                end
            end
        end
        
        function build(self)
            % Initialize all the graphic elements and create figure
            
            if isempty(self.figureNumber)
                self.figureHandle = figure;
                self.figureNumber = get(self.figureHandle, 'Number');
            else
                self.figureHAndle = figure(self.figureNumber);
            end
            
            self.axesHandle = axes();
            view(3)
            
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
            axis equal
            axis vis3d
            
        end 
        
        function update(self,r,C)
            
            elementNames = fieldnames(self.elements);
            numElements = numel(elementNames);
            for lv1 = 1:numElements
                elementObj = self.elements.(elementNames{lv1});
                elementObj.update(r(:,lv1), C(:,:,lv1))
            end
           
            grid on
        end    
    end
end

