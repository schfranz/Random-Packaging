classdef Sphere < ShapeInterface
    %inherited properties:
        %volume     %volume of sphere       %protected
        %shape      %sphere                 %protected
        %width      %diameter
        %height     %diameter
        %center     %center coordinates     %default: [0,0,0]
        
    properties (SetObservable)
        radius  %radius of sphere
    end
    
    methods
        %construtor method
        function obj = Sphere(width, center)
            obj.shape = 'sphere';
            addlistener(obj, 'width', 'PostSet', @Sphere.updateProps);
            addlistener(obj, 'height', 'PostSet', @Sphere.updateProps);
            addlistener(obj, 'radius', 'PostSet', @Sphere.updateProps);
            %addlistener(obj, 'center', 'PostSet', @Sphere.updateLocation);
            switch nargin
                case 0 %no argument constructor
                otherwise %set basic properties of sphere
                    obj.width = width;
                    obj.height = obj.width;
                    obj.radius = obj.width/2;
                    obj.volume = 4/3 * pi * obj.radius^3;
            end
            if (nargin >= 2) %sphere centered around provided origin
                obj.center = center;
            end
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
            
            distToCenter = pdist([obj.center;coords]); %euclidean distance
            
            %decide if point is in shape or not
            if (distToCenter <= obj.radius)
                bool = true;
            else
                bool = false;
            end
        end
        
        %returns true if a point is on the surface of the specified shape
        function bool = isOnShapeSurf(obj, coords)
            if (length(coords) ~= 3)
                error(obj.errMessBadCoord)
            end
            
            distToCenter = pdist([obj.center;coords]); %euclidean distance
            
            %decide if point is in shape or not
            if (distToCenter == obj.radius) %check for reaaaally small deviations?
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
            fprintf('Hehehe, good luck rotating spheres...\n')
        end
    end
        
    methods (Static)
        %update function that respond to data update by user
        function updateProps(~, eventData) %first argument is class info?
            obj = eventData.AffectedObject;
            switch eventData.Source.Name
                case 'width'
                    obj.height = obj.width;
                    obj.radius = obj.width/2;
                    obj.volume = 4/3 * pi * obj.radius^3;
                case 'height'
                    obj.width = obj.height;
                    obj.radius = obj.width/2;
                    obj.volume = 4/3 * pi * obj.radius^3;
                case 'radius'
                    obj.width = obj.radius*2;
                    obj.height = obj.width;
                    obj.volume = 4/3 * pi * obj.radius^3;
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
end