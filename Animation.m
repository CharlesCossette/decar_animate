classdef Animation < handle
    % TODO - check if forgot to build.
    % TODO - dummy-proof the animated trace!!
    properties
        figureNumber
        elements
        traces
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
            % update(r,C) methods. If numberOfCopies is specified, this
            % will also create multiple instances of the provided element.
            
            className = class(element);
            searching = true;
            ind = 1;
            
            % While loop checks to see if there is already an element with
            % the same class name. If so, appends a new index to the name.
            % This is necessary when creating copies.
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
            
            % Now that we have found the next available index, start
            % creating copies.
            if exist('numberOfCopies','var')
                for lv1 = ind : ind + numberOfCopies - 1
                    self.elements.(strcat(className,num2str(lv1)))...
                                                = self.copyObject(element);
                end
            end
        end
        
        function build(self)
            % Initialize all the graphic elements and create figure
            if isempty(self.elements)
                error('You must add at least one element before building.')
            end
            
            % Get current axes (if they exist, will create one otherwise)
            self.axesHandle = gca;
            % Clear content on axes
            cla
            
            % 3D view default. This can be changed after the build.
            % axis temporarily set to some small frame as a hack. Some bug
            % was noticed when using subplots where the window would be way
            % too large. This fixes that.
            axis([0 0.001 0 0.001 0 0.0011])
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
            hold(self.axesHandle, 'on')     
            for lv1 = 2:numElements
                elementObj = self.elements.(elementNames{lv1});
                hold(self.axesHandle, 'on')   
                elementObj.plot([0;0;0], eye(3))
            end
            hold off
            
            % 3D view default. This can be changed after the build.
            axis equal
            axis vis3d
            grid on
            view(3)
            
        end 
        
        function update(self,r,C)
            % Updates all the positions and attitudes of all graphic
            % elements by running the update(r,C) method of all elements.
            % TODO - if something is deleted, recreate it?
            % TODO - throw error if hasnt been built.
            elementNames = fieldnames(self.elements);
            numElements = numel(elementNames);
            for lv1 = 1:numElements
                elementObj = self.elements.(elementNames{lv1});
                % If user has not supplied enough information, feed zero.
                if lv1 > size(r,2) && lv1 > size(C,3)
                    elementObj.update([0;0;0], eye(3))
                elseif lv1 > size(r,2) 
                    elementObj.update([0;0;0],C(:,:,lv1))
                elseif lv1 > size(C,3)
                    elementObj.update(r(:,lv1), eye(3))
                else
                    elementObj.update(r(:,lv1), C(:,:,lv1))
                end

            end
        end    
        
    end
    methods (Access = private)
        function copiedObj = copyObject(self, obj)
            % DEEP COPY 
            % Create a new object of the same class and exactly the
            % same property values as obj. This is necessary because when
            % using handle classes setting obj1 = obj2 makes them the same
            % object by reference.
            className = class(obj);
            props = properties(obj);
            
            copiedObj = eval(className);
            for lv1 = 1:length(props)
                
                if isobject(obj.(props{lv1}))
                    % If properties are also objects then we must copy
                    % their values instead of assigning them by reference.
                    % RECURSION
                    copiedObj.(props{lv1}) = self.copyObject(obj.(props{lv1}));
                else
                    copiedObj.(props{lv1}) = obj.(props{lv1});
                end
            end
            % TODO - check if property is a struct, as this could also
            % contain objects which cant be copied by reference...
        end
    end
end

