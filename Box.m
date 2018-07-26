%TODO:
% - update
% - write checks for nonnegative inputs (also Sphere and Cylinder)

%% This class defines a 3-D rectangle with the longest side as its height 
    %(aligned with z), the medium side as its width (aligned with y), and 
    %the shortest side as its depth (aligned with x).
%%
classdef Box < ShapeInterface
    %inherited properties:
        %volume     %volume of box       %protected
        %shape      %box                 %protected
        %height     %longest side
        %width      %medium side
        %depth      %shortest side
        %center     %center coordinates     %default: [0,0,0]
        %tempHeight %last height before reset
        %tempWidth  %last width before reset
        %tempDepth  %last depth before reset
        %tempCenter %last center before reset
    %%
    %%VARIABLES
    %%PUBLIC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetObservable)
        diagonal  %body diagonal
    end
    
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%CONSTRUCTOR%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
        %construtor method
        function obj = Box(height, width, depth, center)
            obj.shape = 'box';
            switch nargin
                case 0 %no argument constructor
                otherwise %set basic properties of box
                    obj.height = height;
                    obj.width = width;
                    obj.depth = depth;
                    obj.volume = obj.height * obj.width * obj.depth;
                    %check this
                    obj.diagonal = 2*pdist([obj.center; (obj.center - ...
                        [obj.depth/2, obj.width/2, obj.height/2])]);
            end
            if (nargin >= 4) %box centered around provided origin
                obj.center = center;
            end
            %listeners
            addlistener(obj, 'height', 'PostSet', @Box.updateProps);
            addlistener(obj, 'width', 'PostSet', @Box.updateProps);
            addlistener(obj, 'depth', 'PostSet', @Box.updateProps);
            addlistener(obj, 'height', 'PreSet', @FillableBox.updateTempProps);
            addlistener(obj, 'width', 'PreSet', @FillableBox.updateTempProps);
            addlistener(obj, 'depth', 'PreSet', @FillableBox.updateTempProps);
            addlistener(obj, 'center', 'PreSet', @FillableBox.updateTempProps);
            %addlistener(obj, 'center', 'PostSet', @Box.updateLocation);
        end
    end
        
    methods %other methods required to implement interface
        %function obj = getSurfaceCoords(obj, nMeshPoints) %nMeshPoints is number of points in each direction
        %    
        %end
        
        %returns true if a point falls within the specified shape
        %   (including surface)
        function bool = isInShape(obj, coords)
            if (length(coords) ~= 3)
                error(obj.errMessBadCoord)
            end
            
            %{
            a = obj.center(1) + height/2;
            b = obj.center(1) - height/2;
            c = obj.center(2) + width/2;
            d = obj.center(2) - width/2;
            e = obj.center(3) + depth/2;
            f = obj.center(3) - depth/2;
            %}
            
            %decide if point is in shape or not
            %{
            if ((coords(1) < obj.center(1) + obj.height/2) && ...
                    (coords(1) > obj.center(1) - obj.height/2) && ...
                    (coords(2) < obj.center(2) + obj.width/2) && ...
                    (coords(2) > obj.center(2) - obj.width/2) && ...
                    (coords(3) < obj.center(3) + obj.depth/2) && ...
                    (coords(3) > obj.center(3) - obj.depth/2))
                bool = true;
            else
                bool = false;
            end
            %}
            
            %does this work?
            %%{
            if (isOnLine(coords(1), obj.center(1), obj.depth) && ...
                    isOnLine(coords(2), obj.center(2), obj.width) && ...
                    isOnLine(coords(3), obj.center(3), obj.height))
                bool = true;
            else
                bool = false;
            end
            %%}
        end
        
        %returns true if a point is on the surface of the specified shape
        function bool = isOnShapeSurf(obj, coords)
            if (length(coords) ~= 3)
                error(obj.errMessBadCoord)
            end
            
            %does this work?
            %decide if point is on shape surface or not
            if (((coords(3) == (obj.center(3) - obj.height/2)) && ... %on the xy plane?
                    isOnLine(coords(1), obj.center(1), obj.depth) && ...
                    isOnLine(coords(2), obj.center(2), obj.width)) || ...
                    ((coords(1) == (obj.center(1) - obj.depth/2)) && ... %on the yz plane?
                    isOnLine(coords(2), obj.center(2), obj.width) && ...
                    isOnLine(coords(3), obj.center(3), obj.height)) || ...
                    ((coords(2) == (obj.center(2) - obj.width/2)) && ... %on the zx plane?
                    isOnLine(coords(3), obj.center(3), obj.height) && ...
                    isOnLine(coords(1), obj.center(1), obj.depth)))
                bool = true;
            else
                bool = false;
            end
        end
        
        %moves object in xyz as specified by vector coordChange
        function obj = move(obj, coordChange)
            obj.center = obj.center + coordChange;
        end
        
        function obj = rotate(obj, ~, ~, ~, ~)%angle, x, y, z)
            fprintf('Hehehe, cannot rotate boxes yet...\n')
        end
    end
        
    methods (Static)
        %update function that respond to data update by user
        function updateProps(~, eventData) %first argument is class info?
            obj = eventData.AffectedObject;
            switch eventData.Source.Name
                case 'height'
                    obj.volume = obj.height * obj.width * obj.depth;
                    obj.diagonal = 2*pdist([obj.center; (obj.center - ...
                        [obj.depth/2, obj.width/2, obj.height/2])]);
                case 'width'
                    obj.volume = obj.height * obj.width * obj.depth;
                    obj.diagonal = 2*pdist([obj.center; (obj.center - ...
                        [obj.depth/2, obj.width/2, obj.height/2])]);
                case 'depth'
                    obj.volume = obj.height * obj.width * obj.depth;
                    obj.diagonal = 2*pdist([obj.center; (obj.center - ...
                        [obj.depth/2, obj.width/2, obj.height/2])]);
            end
        end
        
        %update function that respond to data update by user
        function updateTempProps(~, eventData) %first argument is class info?
            obj = eventData.AffectedObject;
            switch eventData.Source.Name
                case 'height'
                    obj.tempHeight = obj.height;
                case 'width'
                    obj.tempWidth = obj.width;
                case 'depth'
                    obj.tempDepth = obj.depth;
                case 'center'
                    obj.tempCenter = obj.center;
            end
        end
        
        %update function that responds to location update by user
        %{
        function updateLocation(~, eventData)
            obj = eventData.AffectedObject;
            switch eventData.Source.Name
                case 'center'
                    %updateShapeMesh
            end
        end
        %}
    end
    
    methods (Access = private) %private functions for exclusive use of this class
        %function that determines if a given number is on a line specified
        %in terms of the center of the line and its length (1-D!)
        function bool = isOnLine(number, center, length)
            if (number <= (center - length/2) && number >= center - (length/2))
                bool = true;
            else
                bool = false;
            end            
        end        
    end
end