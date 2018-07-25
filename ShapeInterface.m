%TODO
%   - specify data types of inputs (in superclass or in constructors?)
%   - write function that determines surface coordinates based on origin in
%   center of shape
%   - improve unit tests with assert and stuff
%   - figure out how to explicitly invoke set methods as user
%   - add check for valid input to Sphere.move

classdef (Abstract) ShapeInterface < handle
    %abstract class for creating 3-D shapes, derived from handle to allow
    %   listening
    
    %%
    %%VARIABLES
    %%PUBLIC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetObservable, AbortSet) % update will change entire shape
        height              %height (long end of a shape, identical to width for cube and sphere)
        width               %width of the shape, i.e. the medium end
        depth               %depth of the shape, i.e. the short end
        center = [0,0,0];   %center point of shape
    end
    
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        volume  %volume enclosed by the shape       
        shape   %shape type (cube, sphere, cylinder)
    end
    
    properties (Hidden, Access = protected)% better than (GetAccess = private) because subclasses can still access these
        errMessBadCenter = 'Invalid center coordinates';
        errMessBadCoord = 'Invalid coordinate input';
        errMessTooManyInputs = 'Too many input arguments';
    end
    
    %%PRIVATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%ABSTRACT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (Abstract)
        isInShape(obj)
        isOnShapeSurf(obj)
        move(obj)
        rotate(obj)
    end
    
    %%SET&GET%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
        function set.center(obj, center)
            center = checkCenter(obj, center);
            switch length(center)
                case 1
                    obj.center(1) = center;
                case 2
                    obj.center(1:2) = center;
                case 3
                    obj.center = center;
            end
        end
    end
    
    %%PRIVATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (Access = private)
        %checks for invalid center coordinates
        function center = checkCenter(obj, center)
            if (isempty(center) || length(center) > 3)
                error(obj.errMessBadCenter)
            else
                if (isrow(center) == false)
                    center = center';
                end
            end
        end
    end
end
    