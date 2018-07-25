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
        nFillShapesExp = 10; %number of fill shapes user expects to place
    end
    
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected)
        allowedFillShapes = 'sphere';   %FillShapes that can be used (remove default later)
        mixedShapes = false;        %boolean that is true if FillShapes are different (sizes or shapes)
        nFillShapes = 0;            %number of FillShapes present
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
    end
    
    %%PRIVATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%ABSTRACT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (Abstract)
        canFillHere(obj)
    end    
end