classdef (Abstract) FillableShapeInterface < ShapeInterface
    %abstract class that describes a 3-D shape that is filled with another
    %   3-D shape
    %inherited properties:
        %depth      %depth of shape
        %width      %width of shape
        %height     %height of shape
        %center     %center coordinates     %default: [0,0,0]
        %volume     %volume of shape        %protected
        %shape      %shape type             %protected
        
    %%
    %%VARIABLES
    %%PUBLIC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetObservable, AbortSet)
        nFillShapesExp = 10;    %number of FillShapes user expects to place
        gravityOn = false;      %when true, will exert force towards negative z on all FillShapes
        sequentialDrop = false; %when true, will drop FillShapes sequentially instead of all at once
        goAllIn = false;        %when true, recreates current setting and attempts to place all objects optimally to determine whether new object can be placed at all
    end
    
    properties (Hidden, SetObservable, AbortSet)
        iterDepthMove = 10;     %number of iterations for moving other objects when new object can't be placed
        iterDepthSurvGrid = 3;  %number of iterations for making the grid on an observation object finer
        iterDepthSurvSize = 3;  %number of iterations for making an observation object bigger
    end
    
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        allowedFillShapes = 'sphere';   %FillShapes that can be used (remove default later)
        mixedShapes = false;        %boolean that is true if FillShapes are different (sizes or shapes)
        nFillShapes = 0;            %actual number of FillShapes present
        freeVolume                  %free volume that remains when FillShapes are inside
        isFilled = false            %boolean that is true if a shape is inside the outer shape
        shapeLocs                   %list of FillShape IDs, actual center coordinates, and shape types: [ID, x, y, z, shape]
        shapeLocsOrig               %same as shapeLocs, but with originally intended center coordinates
        coordListX                  %list of actual x coordinates, shape IDs, and types: [x, ID, shape]
        coordListY                  %list of actual y coordinates, shape IDs, and types: [y, ID, shape]
        coordListZ                  %list of actual z coordinates, shape IDs, and types: [z, ID, shape]
    end
    
    properties (Hidden, GetAccess = protected)
        errMessInvalidShape = 'This fill shape type is not supported';
        errMessLargeFillShape = 'The fill shape provided is too large for the canister';
        errMessCantPlaceShape = 'Cannot place fill shape';
        warnMessNshapesIncr = ['Increasing the number of FillShapes present ' ...
            'beyond the specified number of expected FillShapes (nFillShapesExp) ' ...
            'may slow down placement of additional shapes. Consider increasing ' ...
            'nFillShapesExp.']; %figure out newline
    end
    
    %%PRIVATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%ABSTRACT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (Abstract)
        addShape(obj)       %function that adds a FillShape 
        deleteShape(obj)    %function that deletes a FillShape
        %canFillHere(obj) %?
        %dropEvenly(obj)     %function to evenly distribute FillShapes (not important rn)
        placeFillShapesRand(obj)   %function to randomly distribute FillShapes
        %getSurfaceCoords(obj) %this should already exist as part of ShapeInterface
    end
    
    %%SET&GET%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (Access = protected, Hidden)
        %function that checks if a suggested FillShape is allowed
        function bool = checkValidFillShape(obj, fillShape)
            bool = false;
            if (obj.allowedFillShapes(:) ~= fillShape.shape)
                error(obj.errMessInvalidShape)
            else
                bool = true;
            end
        end
        %findDropArea(obj)  %function that determines where shapes can be dropped
        %moveObj(obj)       %function that moves an object if it overlaps with sth
        %rotateObj(obj)     %function that rotates an object if it overlaps
    end
end