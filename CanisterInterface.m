%TODO
%   - specify data types of inputs (in superclass or in constructors?)
%   - write function that determines surface coordinates based on origin in
%   center of shape

classdef CanisterInterface < handle
    %abstract class for creating a canister that is filled with different 
    %   shapes
    
    %%
    %%VARIABLES
    %%PUBLIC%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties
        %canisterShape   %determines which shape the canister has
        %canisterGeom    %specifies geometry of canister
        %fillShapes              %type of fill shape; if array, each entry corresponds to geometry
        %fillShapeGeom   %specifies width and/or height for each fill shape
        allowOverlap = false    %boolean that is true when fill shapes can overlap
        moveToFit = false       %boolean that is true when already placed shapes can be relocated if new ones don't fit
    end
    
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties (SetAccess = protected) %can't be set by user
        allowedFillShapes = 'sphere';   %fill shapes that can be used
        nFillShapes = 0;    %number of fill shapes present
        freeVolume          %volume that is void if all filling volumes are inside
        mixed = false;      %boolean that is true if all filling shapes are identical
        isFilled = false;   %boolean that is true if a shape is inside the canister
        fillLocs            %column matrix with fill shape ID, x, y, and z coordinates of all present fill shapes
        fillLocsOrig        %column matrix like fillLocs, but with originally intended locations, i.e. before moving things around; empty if allowOverlap = true
    end
    
    properties (Hidden, GetAccess = protected)
        errMessInvalidShape = 'This fill shape type is not supported';
        errMessLargeFillShape = 'The fill shape provided is too large for the canister';
    end
    
    %%PRIVATE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%
    %%FUNCTIONS
    %%ABSTRACT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods
        addShape(obj)       %function that adds a fill shape 
        deleteShape(obj)    %function that deletes a fill shape
        %changeCanister     %function to change the canister
        %dropEvenly(obj)    %function to evenly distribute fill shapes
        %dropRandomly(obj)  %function to randomly distribute fill shapes
        %xyzCoords = getSurfaceCoords(obj)
    end
    
    %%SET&GET%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%PROTECTED%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods (Access = protected, Hidden)
        %function that checks if a suggested fillShape is an allowed fill shape
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
    