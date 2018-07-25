classdef (Abstract) FillableShapeInterface < ShapeInterface
    %abstract class that describes a 3-D shape that is filled with another
    %   3-D shape
    %inherited properties:
        %volume     %volume of shape        %protected
        %shape      %shape type             %protected
        %height     %height of shape
        %width      %width of shape
        %depth      %depth of shape
        %center     %center coordinates     %default: [0,0,0]
    
    %%
    %%VARIABLES
    %%PUBLIC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties
        nFillShapesExp = 10; %number of FillShapes user expects to place
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
        errMessInvalidShape = 'This fill shape type is not supported \n';
        errMessLargeFillShape = 'The fill shape provided is too large for the canister';
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
        addShape(obj)       %function that adds a fill shape 
        deleteShape(obj)    %function that deletes a fill shape
        %canFillHere(obj) %?
        %dropEvenly(obj)     %function to evenly distribute fill shapes (not important rn)
        %dropRandomly(obj)   %function to randomly distribute fill shapes
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