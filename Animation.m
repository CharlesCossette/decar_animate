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
            % Add a graphic element to the list of elements in this
            % animation. Requires a valid element object with plot(r,C) and
            % update(r,C) functions. If numberOfCopies is specified, this
            % will also create multiple instances of the provided element.
            % TODO  - incorporate custom properties
            
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
            
            % Get current axes (if they exist, will create one otherwise)
            self.axesHandle = gca;
            % Clear content on axes
            cla
            % 3D view default. This can be changed after the build
            axis equal
            axis vis3d
            grid on
            view(3)
            
            % Get elements in current animation object
            elementNames = fieldnames(self.elements);
            numElements = numel(elementNames);
            
            % Loop through each element object and run plot(r,C) method
            hold off
            elementObj = self.elements.(elementNames{1});
            elementObj.plot([0;0;0], eye(3))
            hold on    
            for lv1 = 2:numElements
                elementObj = self.elements.(elementNames{lv1});
                elementObj.plot([0;0;0], eye(3))

            end
            hold off
            
            
        end 
        
        function update(self,r,C)
            % Updates all the positions and attitudes of all graphic
            % elements by running the update(r,C) method of all elements.
            
            elementNames = fieldnames(self.elements);
            numElements = numel(elementNames);
            for lv1 = 1:numElements
                elementObj = self.elements.(elementNames{lv1});
                elementObj.update(r(:,lv1), C(:,:,lv1))
            end
        end    
    end
end

