classdef Cylinder < ShapeInterface
    %inherited properties:
        %volume     %volume of cylinder     %protected
        %shape      %cylinder               %protected
        %width      %diameter
        %height     %diameter
        %center     %center coordinates     %default: [0,0,0]
        
    properties (SetObservable)
        radius  % radius of cylinder bottom
    end
    
    methods
        %constructor method
        function obj = Cylinder(width, height, center, varargin)
            obj.shape = 'cylinder';
            switch nargin
                case 0 %no argument constructor
                case 1 %only width is specified -> set cylinders to unit height
                    obj.width = width;
                    obj.height = 1;
                    obj.radius = obj.width/2;
                    obj.volume = pi * obj.radius^2 * obj.height;
                otherwise %set basic properties of cylinder
                    obj.width = width;
                    obj.height = height;
                    obj.radius = obj.width/2;
                    obj.volume = pi * obj.radius^2 * obj.height;
            end
            if (nargin >= 3) %cylinder centered around provided origin (base is in xy plane)
                obj.center = center;
            end
            %listeners
            addlistener(obj, 'width', 'PostSet', @Cylinder.updateProps);
            addlistener(obj, 'height', 'PostSet', @Cylinder.updateProps);
            addlistener(obj, 'radius', 'PostSet', @Cylinder.updateProps);
        end
    end
    
    methods %other methods required to implement interface
        %returns true if a point falls within the specified shape
        %   (including surface)
        function bool = isInShape(obj, coords)
            if (length(coords) ~= 3)
                error(obj.errMessBadCoord)
            end
            
            %TODO deal with rotated shapes
            radialLocation = pdist([obj.center(1:2);coords(1:2)]); %euclidean distance
            vertDistToCenter = pdist([obj.center(3);coords(3)]);
            
            %decide if point is in shape or not
            if (radialLocation <= obj.radius && vertDistToCenter <= obj.height/2)
                bool = true;
            else
                bool = false;
            end
            
            warning('Gives wrong answers if cylinder is rotated')
        end
        
        %returns true if a point is on the surface of the specified shape
        function bool = isOnShapeSurf(obj, coords)
            if (length(coords) ~= 3)
                error(obj.errMessBadCoord)
            end
            
            %TODO deal with rotated shapes
            radialLocation = pdist([obj.center(1:2);coords(1:2)]); %euclidean distance
            vertDistToCenter = pdist([obj.center(3);coords(3)]);
            
            %decide if point is in shape or not
            if (radialLocation == obj.radius && vertDistToCenter == obj.height/2)
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
            fprintf('Hehehe, no rotating cylinders yet...\n')
        end        
    end
    
    methods (Static)
        function updateProps(~, eventData) %first argument is class info?
            obj = eventData.AffectedObject;
            switch eventData.Source.Name
                case 'width'
                    obj.radius = obj.width/2;
                    obj.volume = pi * obj.radius^2 * obj.height;
                case 'height'
                    obj.volume = pi * obj.radius^2 * obj.height;
                case 'radius'
                    obj.width = obj.radius*2;
                    obj.volume = pi * obj.radius^2 * obj.height;
            end         
        end
    end
end