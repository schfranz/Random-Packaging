%TODO:
% - write constructor with radius
% - change listener structure: directly listening to variables introduces a
% ton of redundancy and is stupid. replace with actual events that are
% triggered by proper set and get methods

classdef Sphere < ShapeInterface
    %inherited properties:
        %volume     %volume of sphere       %protected
        %shape      %sphere                 %protected
        %height     %diameter
        %width      %diameter
        %depth      %diameter
        %center     %center coordinates     %default: [0,0,0]
        
    properties (SetObservable, AbortSet)
        radius  %radius of sphere
        diameter  %diameter of sphere
    end
    
    methods
        %construtor method
        function obj = Sphere(diameter, center)
            obj.shape = 'sphere';
            switch nargin
                case 0 %no argument constructor
                    %listeners
                    addlistener(obj, 'height', 'PostSet', @Sphere.updateProps);
                    addlistener(obj, 'width', 'PostSet', @Sphere.updateProps);
                    addlistener(obj, 'depth', 'PostSet', @Sphere.updateProps);
                    addlistener(obj, 'radius', 'PostSet', @Sphere.updateProps);
                    addlistener(obj, 'diameter', 'PostSet', @Sphere.updateProps);
                otherwise %set basic properties of single Sphere or array of Sphere objects
                    numElem = numel(diameter);
                    obj = repelem(obj, numElem, 1); %column vector
                    for k = 1:numElem
                        obj(k).diameter = diameter(k);
                        obj(k).height = obj(k).diameter;
                        obj(k).width = obj(k).diameter;
                        obj(k).depth = obj(k).diameter;
                        obj(k).radius = obj(k).diameter/2;
                        obj(k).volume = 4/3 * pi * obj(k).radius^3;
                        %listeners
                        addlistener(obj(k), 'height', 'PostSet', @Sphere.updateProps);
                        addlistener(obj(k), 'width', 'PostSet', @Sphere.updateProps);
                        addlistener(obj(k), 'depth', 'PostSet', @Sphere.updateProps);
                        addlistener(obj(k), 'radius', 'PostSet', @Sphere.updateProps);
                        addlistener(obj(k), 'diameter', 'PostSet', @Sphere.updateProps);
                    end
            end
            
            if (nargin >= 2) %sphere centered around provided origin
                obj.center = center;
            end
% %             listeners
% %             addlistener(obj, 'height', 'PostSet', @Sphere.updateProps);
% %             addlistener(obj, 'width', 'PostSet', @Sphere.updateProps);
% %             addlistener(obj, 'depth', 'PostSet', @Sphere.updateProps);
% %             addlistener(obj, 'radius', 'PostSet', @Sphere.updateProps);
% %             addlistener(obj, 'diameter', 'PostSet', @Sphere.updateProps);
% %             addlistener(obj, 'center', 'PostSet', @Sphere.updateLocation);
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
                case 'height'
                    obj.width = obj.height;
                    obj.depth = obj.height;
                    obj.radius = obj.height/2;
                    obj.diameter = obj.height;
                    obj.volume = 4/3 * pi * obj.radius^3;
                case 'width'
                    obj.height = obj.width;
                    obj.depth = obj.width;
                    obj.radius = obj.width/2;
                    obj.diameter = obj.width;
                    obj.volume = 4/3 * pi * obj.radius^3;
                case 'depth'
                    obj.height = obj.depth;
                    obj.width = obj.depth;
                    obj.radius = obj.depth/2;
                    obj.diameter = obj.depth;
                    obj.volume = 4/3 * pi * obj.radius^3;
                case 'radius'
                    obj.height = obj.radius*2;
                    obj.width = obj.height;
                    obj.depth = obj.height;
                    obj.diameter = obj.height;
                    obj.volume = 4/3 * pi * obj.radius^3;
                case 'diameter'
                    obj.height = obj.diameter;
                    obj.width = obj.diameter;
                    obj.depth = obj.diameter;
                    obj.radius = obj.diameter/2;
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